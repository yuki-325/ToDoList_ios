//
//  RealmUtils.swift
//  ToDoList_ios
//
//  Created by 中野勇貴 on 2021/04/13.
//

import RealmSwift

struct RealmUtils {
    static let realm = try! Realm()
    
    //DBにデータを保存
    static func saveData(with newPlan: Plan) {
        //DBにnewPlanを追加
        try! realm.write {
            realm.add(newPlan)
        }
    }
    
    //DBからデータを読み込み
    static func loadData() -> [Plan]{
        var plans: [Plan] = []
        let results = realm.objects(Plan.self).sorted(byKeyPath: "date", ascending: true)
        
        for result in results {
            plans.append(result)
        }
        return plans
    }
    
    //DBのデータを更新
    static func updateData(planId: String, title: String, content: String, date: Date) {
        let targetPlan = realm.objects(Plan.self).filter("id == '\(planId)'")
        
        do{
            try realm.write{
                targetPlan[0].title = title
                targetPlan[0].content = content
                targetPlan[0].date = date
                targetPlan[0].createdAt = Date()
            }
        }catch {
            print("Error \(error)")
        }
    }
    
    static func daleteData(planId: String) {
        let targetPlan = realm.objects(Plan.self).filter("id == '\(planId)'")
        
        do{
            try realm.write{
                realm.delete(targetPlan[0])
            }
        }catch {
            print("Error \(error)")
        }
    }
    
}
