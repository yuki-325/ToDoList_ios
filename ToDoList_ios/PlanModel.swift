//
//  PlanModel.swift
//  ToDoList_ios
//
//  Created by 中野勇貴 on 2021/03/22.
//

import Foundation
import RealmSwift

class Plan: Object {
    @objc dynamic var id: String = NSUUID().uuidString
    @objc dynamic var title: String = ""
    @objc dynamic var content: String = ""
    @objc dynamic var date: Date = Date()
    @objc dynamic var createdAt: Date = Date()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}
