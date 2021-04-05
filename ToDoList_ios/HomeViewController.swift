//
//  ViewController.swift
//  ToDoList_ios
//
//  Created by 中野勇貴 on 2021/01/27.
//

import UIKit
import MaterialComponents.MaterialButtons
import RealmSwift

class HomeViewController: UIViewController {

    @IBOutlet weak var toDoTableView: UITableView!
    @IBOutlet weak var floatActionBtn: MDCFloatingButton!
    var plans: [Plan] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toDoTableView.delegate = self
        toDoTableView.dataSource = self
        toDoTableView.register(UINib(nibName: C.toDoCellNibName, bundle: nil), forCellReuseIdentifier: C.toDoCellIdentifier)
        floatActionBtn.inkColor = UIColor(named: C.Colors.dark)
        floatActionBtn.inkStyle = .bounded
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func loadData() {
        do {
            let realm = try Realm()
            let results = realm.objects(Plan.self).sorted(byKeyPath: "date", ascending: true)
            
            for result in results {
                plans.append(result)
            }
        } catch let error {
            print(error.localizedDescription)
        }
        DispatchQueue.main.async {
            self.toDoTableView.reloadData() //tableViewをリロード
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return plans.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: C.toDoCellIdentifier, for: indexPath) as! ToDoCell
        cell.whatLabel.text = plans[indexPath.row].title
        cell.whyLabel.text = plans[indexPath.row].content
        cell.whenLabel.text = DateUtils.stringFromDate(date: plans[indexPath.row].date as! Date, format: "yyyy/MM/dd")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
