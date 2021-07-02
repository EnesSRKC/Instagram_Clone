//
//  DatabaseManager.swift
//  InstagramClone
//
//  Created by Enes Sirkecioğlu on 30.06.2021.
//

import FirebaseDatabase

public class DatabaseManager {
    static let shared = DatabaseManager()
    
    let database = Database.database().reference()
    
    
    
    public func canCreateNewUser(with email: String, username: String, password: String, completion: (Bool)-> Void){
        completion(true)
    }
    
    public func insertNewUser(with email: String, username: String, completion: @escaping (Bool)->Void) {
        let key = email.safeDatabaseKey()
        
        database.child(key).setValue(["Username": username]) { Error, DatabaseReference in
            if Error == nil {
                completion(true)
                return
            }
            else {
                completion(false)
                return
            }
        }
    }
    
}
