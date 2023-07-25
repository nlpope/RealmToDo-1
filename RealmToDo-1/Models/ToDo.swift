//
//  ToDo.swift
//  RealmToDo-1
//
//  Created by Noah Pope on 7/25/23.
//

import Foundation
import RealmSwift

class ToDo: Object {
     
    @Persisted var name: String
    @Persisted var completed = false
    //@Persisted guarantees a default value, so no errors
    //upsert = inserting an object that doesnt exist or updating one that does
}
