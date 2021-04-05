//
//  AppDelegate.swift
//  ToDoList_ios
//
//  Created by 中野勇貴 on 2021/01/27.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Realmマイグレーションバージョン
        // レコードフォーマットを変更する場合、このバージョンも上げていく。
        let migSchemaVersion: UInt64 = 5

        // マイグレーション設定
        var config = Realm.Configuration(
            schemaVersion: migSchemaVersion,
            migrationBlock: { migration, oldSchemaVersion in
                if (oldSchemaVersion < migSchemaVersion) {
        }})
        Realm.Configuration.defaultConfiguration = config
        config = Realm.Configuration()
        config.deleteRealmIfMigrationNeeded = true
        
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

