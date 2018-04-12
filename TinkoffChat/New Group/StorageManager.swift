//
//  StorageManager.swift
//  TinkoffChat
//
//  Created by m.kuznetsov1 on 11.04.2018.
//  Copyright © 2018 Maxim Kuznetsov. All rights reserved.
//

import Foundation
import CoreData

class StorageManager {
    
    private static var _coreDataStack: CoreDataStack?
    public static var coreDataStack: CoreDataStack? {
        get {
            if _coreDataStack == nil {
                _coreDataStack = CoreDataStack()
            }
            return _coreDataStack
        }
    }
    
    static func save() {
        if let context = self.coreDataStack?.saveContext {
            self.coreDataStack?.performSave(context: context, completion: {
                print("Save context success!")
            })
        } else {
            print("Unable to save context!")
        }
    }
    
    static func getAppUser() -> AppUser? {
        if let context = self.coreDataStack?.saveContext {
            return findOrInsertAppUser(in: context)
        }
        
        return nil
    }
    
    static func findOrInsertAppUser(in context: NSManagedObjectContext) -> AppUser? {
        guard let model = context.persistentStoreCoordinator?.managedObjectModel else {
            print("Model is not availible in context!")
            assert(false)
            return nil
        }
        
        var appUser: AppUser?
        guard let fetchRequest = AppUser.fetchRequestAppUser(model: model) else {
            return nil
        }
        
        do {
            let results = try context.fetch(fetchRequest)
            assert(results.count < 2, "Multiple AppUsers found!")
            if let foundUser = results.first {
                appUser = foundUser
            }
        } catch {
            print("Failed to fetch AppUSer: \(error)")
        }
        
        if appUser == nil {
            appUser = AppUser.insertAppUser(in: context)
        }
        
        return appUser
    }
    
    static func saveToStorage(profile: Profile) -> Bool {
        
        if let context = StorageManager.coreDataStack?.saveContext {
            if let appUser = StorageManager.findOrInsertAppUser(in: context)?.currentUser {
                appUser.name = profile.name
                appUser.additionalInfo = profile.desc
                if let profilePhoto = profile.photo {
                    appUser.image =  UIImagePNGRepresentation(profilePhoto) as Data?
                }
                StorageManager.coreDataStack?.performSave(context: context, completion: {})
                
                return true
            }
        }
        
        return false
    }
}
