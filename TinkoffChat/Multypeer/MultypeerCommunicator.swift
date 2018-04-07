//
//  MultypeerCommunicator.swift
//  TinkoffChat
//
//  Created by MacBookPro on 01/04/2018.
//  Copyright © 2018 Maxim Kuznetsov. All rights reserved.
//

import Foundation
import MultipeerConnectivity

protocol Communicator {
    func sendMessage(string: String, to userID: String, completionHandler: ((_ success: Bool, _ error: Error?) -> ())?)
    weak var delegate: CommunicatorDelegate? { get set }
    var online: Bool { get set }
}

class MultipeerCommunicator: NSObject, Communicator {
    let serviceType = "tinkoff-chat"
    weak var delegate: CommunicatorDelegate?
    weak var conversationDelegate: CommunicatorDelegate?
    
    let advertiser: MCNearbyServiceAdvertiser
    let browser: MCNearbyServiceBrowser
    
    let localPeerID = MCPeerID(displayName: "A Hero")
    
    var sessions = [String: MCSession]()
    var online: Bool
    
    override init() {
        advertiser = MCNearbyServiceAdvertiser(peer: localPeerID,
                                               discoveryInfo: ["userName": "A Hero"],
                                                   serviceType: serviceType)
        
        browser = MCNearbyServiceBrowser(peer: localPeerID,
                                             serviceType: serviceType)
        online = true
        advertiser.startAdvertisingPeer()
        browser.startBrowsingForPeers()
        
        super.init()
        
        advertiser.delegate = self
        browser.delegate = self
    }
    
    func sendMessage(string: String, to userID: String, completionHandler: ((_ success: Bool, _ error: Error?) -> ())?) {
        let message = [
            "eventType" : "TextMessage",
            "messageId" : String.generateMessageId(),
            "text" : string
        ]
        
        do {
            if let session = sessions[userID] {
                let data = try JSONSerialization.data(withJSONObject: message, options: [])
                try session.send(data, toPeers: session.connectedPeers, with: .reliable)
            }
        } catch {
            print("Unable to send message")
        }
    }

}

extension MultipeerCommunicator: MCNearbyServiceAdvertiserDelegate {
    
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser,
                    didReceiveInvitationFromPeer peerID: MCPeerID,
                    withContext context: Data?,
                    invitationHandler: @escaping (Bool, MCSession?) -> Void)
    {
        
        let session = MCSession(peer: self.localPeerID, securityIdentity: nil, encryptionPreference: .none)
        session.delegate = self
        sessions[peerID.displayName] = session
        
        invitationHandler(true, session)
    }
}

extension MultipeerCommunicator: MCSessionDelegate {
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        do {
            if let receivedData = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                if let conversationDelegate = conversationDelegate {
                    conversationDelegate.didReceiveMessage(text: receivedData["text"] as! String, fromUser: peerID.displayName, toUser: self.localPeerID.displayName)
                } else {
                    delegate?.didReceiveMessage(text: receivedData["text"] as! String, fromUser: peerID.displayName, toUser: self.localPeerID.displayName)
                }
            }
        } catch {
            print("Unable to receive data")
        }
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        
    }

}

extension MultipeerCommunicator: MCNearbyServiceBrowserDelegate {
    
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        let session = MCSession(peer: self.localPeerID, securityIdentity: nil, encryptionPreference: .none)
        session.delegate = self
        sessions[peerID.displayName] = session
        
        browser.invitePeer(peerID, to: session, withContext: nil, timeout: 60)
        delegate?.didFoundUser(userID: peerID.displayName, userName: info?["userName"])
        conversationDelegate?.didFoundUser(userID: peerID.displayName, userName: info?["userName"])
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        delegate?.didLostUser(userID: peerID.displayName)
        conversationDelegate?.didLostUser(userID: peerID.displayName)
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: Error) {
        print("Did not start browsing")
    }
}


