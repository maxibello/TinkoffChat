//
//  User.swift
//  TinkoffChat
//
//  Created by m.kuznetsov1 on 11.04.2018.
//  Copyright © 2018 Maxim Kuznetsov. All rights reserved.
//

import Foundation
import CoreData

extension User {
    
    static let userId = "Test User Id"
    
    static func findOrInsertAppUser(with: String, in context: NSManagedObjectContext) -> User? {
        guard let model = context.persistentStoreCoordinator?.managedObjectModel else {
            print("Model is not availible in context!")
            assert(false)
            return nil
        }
        
        var appUser: User?
        guard let fetchRequest = User.fetchRequestUser(with: with, model: model) else {
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
            appUser = User.insertAppUser(with: with, in: context)
        }
        
        return appUser
    }
    
    static func insertAppUser(with: String, in context: NSManagedObjectContext) -> User? {
        let appUser = insertUser(in: context, name: "Name Surname", userId: userId)
        appUser?.additionalInfo = "Some info"
        appUser?.image = nil
        
        return appUser
    }
    
    static func insertUser(in context: NSManagedObjectContext, name: String, userId: String) -> User? {
        let user = NSEntityDescription.insertNewObject(forEntityName: "User", into: context) as? User
        user?.name = name
        user?.userId = userId
        
        return user
    }
    
    static func fetchRequestUser(with: String, model: NSManagedObjectModel) -> NSFetchRequest<User>? {
        let templateName = "User"
        guard let fetchRequest = model.fetchRequestFromTemplate(withName: templateName, substitutionVariables: ["id" : with]) as? NSFetchRequest<User> else {
            assert(false, "No template with name \(templateName)!")
            return nil
        }
        
        return fetchRequest
    }
}
