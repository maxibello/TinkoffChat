//
//  OperationManager.swift
//  TinkoffChat
//
//  Created by m.kuznetsov1 on 30.03.2018.
//  Copyright © 2018 Maxim Kuznetsov. All rights reserved.
//

import Foundation

class OperationManager: Operation {
    
    var profile: Profile?
    var completion: ((Bool) -> ())?
    
    init(profile: Profile, completion: @escaping (Bool) -> ()) {
        self.profile = profile
        self.completion = completion
    }
    
    override func main() {
        if let profile = profile {
            let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(profile, toFile: Profile.archiveURL.path)
            completion!(isSuccessfulSave)
        }
        
    }
    func save() {
        OperationQueue().addOperation(self)
    }
}
