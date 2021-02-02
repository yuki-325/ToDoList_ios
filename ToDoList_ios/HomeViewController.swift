//
//  ViewController.swift
//  ToDoList_ios
//
//  Created by 中野勇貴 on 2021/01/27.
//

import UIKit
import MaterialComponents.MaterialButtons

class HomeViewController: UIViewController {
    
    
    
    @IBOutlet weak var toDoTableView: UITableView!
    @IBOutlet weak var floatActionBtn: MDCFloatingButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toDoTableView.delegate = self
        toDoTableView.dataSource = self
        toDoTableView.register(UINib(nibName: C.toDoCellNibName, bundle: nil), forCellReuseIdentifier: C.toDoCellIdentifier)
        
        floatActionBtn.inkColor = UIColor(named: C.Colors.dark)
        floatActionBtn.inkStyle = .bounded
    }
    
    // スクロール中に呼ばれる
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 表示・非表示を綺麗に見せるために、アニメーションを適用
        UIView.animate(withDuration: 0.25) {
            self.floatActionBtn.alpha = 0
        }
    }
    
    // スクロールが終わった時に呼ばれる
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        UIView.animate(withDuration: 0.25) {
            self.floatActionBtn.alpha = 1
        }
    }
    
    // ドラッグスクロールが終わった時に呼ばれる
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        UIView.animate(withDuration: 0.25) {
            self.floatActionBtn.alpha = 1
        }
    }
    
    @IBAction func floatActionBtnPressed(_ sender: Any) {
        
    }
    
}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: C.toDoCellIdentifier, for: indexPath) as! ToDoCell
        cell.whatLabel.text = "WhatWhatWhatWhatWhatWhatWhatWhatWhatWhatWhatWhatWhatWhatWhatWhatWhat"
        cell.whyLabel.text = "Whyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy"
        cell.whenLabel.text = "yyyy/mm/dd まで"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
