//
//  ToDo.swift
//  RealmToDo-1
//
//  Created by Noah Pope on 7/25/23.
//

import Foundation
import RealmSwift

class ToDo: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    //can only have 1 primary key per class
    @Persisted var name: String
    @Persisted var completed = false
    @Persisted var urgency: Urgency = .neutral
    //@Persisted guarantees a default value, so no errors
    //upsert = inserting an object that doesnt exist or updating one that does
    
    enum Urgency: Int, PersistableEnum {
        case trivial, neutral, urgent
        
        var text: String {
            switch self {
            case .trivial:
                return "Trivial"
            case .neutral:
                return "Neutral"
            case .urgent:
                return "Urgent"
            }
        }
    }
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
}
