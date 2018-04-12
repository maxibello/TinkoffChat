//
//  AppUser.swift
//  TinkoffChat
//
//  Created by m.kuznetsov1 on 11.04.2018.
//  Copyright © 2018 Maxim Kuznetsov. All rights reserved.
//

import Foundation
import CoreData

extension AppUser {
    
    static func fetchRequestAppUser(model: NSManagedObjectModel) -> NSFetchRequest<AppUser>? {
        let templateName = "AppUser"
        guard let fetchRequest = model.fetchRequestTemplate(forName: templateName) as? NSFetchRequest<AppUser> else {
            assert(false, "No template with name \(templateName)!")
            return nil
        }
        
        return fetchRequest
    }
    
    static func insertAppUser(in context: NSManagedObjectContext) -> AppUser? {
        if let appUser = NSEntityDescription.insertNewObject(forEntityName: "AppUser", into: context) as? AppUser {
            if appUser.currentUser == nil {
                let currentUser = User.findOrInsertAppUser(with: User.userId, in: context) 
                appUser.currentUser = currentUser
            }
            return appUser
        }
        return nil
    }
}
