//
//  TaskRealm.swift
//  SimbirSoftApp
//
//  Created by Jazzband on 21.12.2024.
//

import RealmSwift

class TaskRealm: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var title: String
    @Persisted var taskDescription: String
    @Persisted var date: Date
}
