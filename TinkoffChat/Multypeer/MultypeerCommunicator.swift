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
    
    var delegate: CommunicatorDelegate?
    let advertiser: MCNearbyServiceAdvertiser
    let browser: MCNearbyServiceBrowser
    let localPeerID: MCPeerID
    let serviceType = "tinkoff-chat"
    var online: Bool = false
    
    override init() {
        
        localPeerID = MCPeerID(displayName: UIDevice.current.name)
        advertiser = MCNearbyServiceAdvertiser(peer: localPeerID,
                                               discoveryInfo: ["userName": "Saylor Moon"],
                                                   serviceType: serviceType)
        browser = MCNearbyServiceBrowser(peer: localPeerID,
                                             serviceType: serviceType)
        advertiser.startAdvertisingPeer()
        browser.startBrowsingForPeers()
        
        super.init()
        
        advertiser.delegate = self
        browser.delegate = self
    }
    
    func sendMessage(string: String, to userID: String, completionHandler: ((Bool, Error?) -> ())?) {
        
    }

}

extension MultipeerCommunicator: MCNearbyServiceAdvertiserDelegate {
    
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser,
                    didReceiveInvitationFromPeer peerID: MCPeerID,
                    withContext context: Data?,
                    invitationHandler: @escaping (Bool, MCSession?) -> Void)
    {
        
        // вот тут что-то с сессиями нужно нашаманить???
        
        let session = MCSession(peer: localPeerID,
                                securityIdentity: nil,
                                encryptionPreference: .none)
        session.delegate = self
        
        invitationHandler(true, session)
    }
}

extension MultipeerCommunicator: MCSessionDelegate {
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        let message = String(data: data, encoding: .utf8)
        print("\(String(describing: message))")
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
        
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: Error) {
        
    }
}


