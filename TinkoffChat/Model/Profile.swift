//
//  Profile.swift
//  TinkoffChat
//
//  Created by m.kuznetsov1 on 29.03.2018.
//  Copyright © 2018 Maxim Kuznetsov. All rights reserved.
//

import Foundation
import os.log

struct PropertyKey {
    static let name = "name"
    static let desc = "desc"
    static let photo = "photo"
}

class Profile: NSObject, NSCoding {
    
    var name: String
    var desc: String?
    var photo: UIImage?
    
    static let documentsDirectory = getDocumentsDirectory()
    static let archiveURL = documentsDirectory.appendingPathComponent("profile")
    
    init(name: String, desc: String? = nil, photo: UIImage? = nil) {
        self.name = name
        self.desc = desc
        self.photo = photo
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the profile name.", log: OSLog.default, type: .debug)
            return nil
        }
        let desc = aDecoder.decodeObject(forKey: PropertyKey.desc) as? String
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        
        self.init(name: name, desc: desc, photo: photo)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(desc, forKey: PropertyKey.desc)
        aCoder.encode(photo, forKey: PropertyKey.photo)
    }
}
