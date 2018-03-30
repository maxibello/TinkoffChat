//
//  GCDManager.swift
//  TinkoffChat
//
//  Created by m.kuznetsov1 on 30.03.2018.
//  Copyright © 2018 Maxim Kuznetsov. All rights reserved.
//

import Foundation

class GCDManager {
    
    func save(profile: Profile, completion: @escaping(Bool) -> ()) {
        let queue = DispatchQueue.global(qos: .utility)
        queue.async{
            let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(profile, toFile: Profile.archiveURL.path)
            completion(isSuccessfulSave)
        }
    }
    
    func load(profile: @escaping (Profile?) -> ()) {
        let queue = DispatchQueue.global(qos: .utility)
        queue.async{
            let loadedProfile = NSKeyedUnarchiver.unarchiveObject(withFile: Profile.archiveURL.path) as? Profile
            profile(loadedProfile)
        }
    }
}
