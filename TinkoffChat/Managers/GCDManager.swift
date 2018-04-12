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
            let savingResult = StorageManager.saveToStorage(profile: profile)
            completion(savingResult)
        }
    }
    
    func load(profile: @escaping(Profile?) -> ()) {
        let queue = DispatchQueue.global(qos: .utility)
        queue.async{
            var loadedProfile: Profile?
            if let appUser = StorageManager.getAppUser()?.currentUser {
                var profileImage: UIImage?
                if let profileImageData = appUser.image {
                    profileImage = UIImage(data:profileImageData, scale:1.0)
                }
                if let userName = appUser.name {
                    loadedProfile = Profile(name: userName, desc: appUser.additionalInfo, photo: profileImage)
                }
                profile(loadedProfile)
            } else {
                profile(loadedProfile)
            }
        }
    }
}
