//
//  AddPlanViewController.swift
//  ToDoList_ios
//
//  Created by 中野勇貴 on 2021/03/09.
//

import UIKit
import UITextView_Placeholder

class AddPlanViewController: UIViewController {
    
    @IBOutlet weak var titleBgView: UIView!
    @IBOutlet weak var contentBgView: UIView!
    @IBOutlet weak var dateBgView: UIView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var dateTextField: UITextField!
    
    //dateTextField用Picker
    lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date //DatePickerModeをDate(日付)に設定
        datePicker.locale = NSLocale(localeIdentifier: "ja_JP") as Locale // DatePickerを日本語化
        datePicker.preferredDatePickerStyle = .wheels // datePickerのstyleを指定
        return datePicker
    }()
    
    //datePicker用DateFormatter
    var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        //持ってくるデータのフォーマットを設定
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP") as Locale?
        dateFormatter.dateStyle = DateFormatter.Style.medium
        return dateFormatter
    }
    
    //datePicker用toolBar
    lazy var toolbar: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // Doneボタンを設定(押下時doneClickedが起動)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneClicked))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        // Doneボタンを追加
        toolbar.setItems([spacelItem, doneButton], animated: true)
        //toolbar.barStyle = .black
        return toolbar
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //各テキスト入力フォームの背景ViewにcornerRadiusを設定
        titleBgView.layer.cornerRadius = titleBgView.frame.height / 3
        contentBgView.layer.cornerRadius = contentBgView.frame.height / 5
        dateBgView.layer.cornerRadius = dateBgView.frame.height / 2
        
        //titleTextFieldのplaceholderを設定
        titleTextField.attributedPlaceholder = NSAttributedString(string: "デートの題名"
                                                                  , attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(named: C.Colors.gray)!])
        
        //contentTextViewのplaceholderを設定
        contentTextView.placeholder = "行く場所・やることなど"
        contentTextView.placeholderColor = UIColor.init(named: C.Colors.gray)
        
        //dateTextFieldのplaceholderを設定
        dateTextField.attributedPlaceholder = NSAttributedString(string: "yyyy/mm/dd"
                                                                 , attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(named: C.Colors.gray)!])
        
        dateTextField.delegate = self //手入力防止用
        
        //dateTextFieldにdatepickerを設定
        dateTextField.inputView = datePicker // textFieldのinputViewにdatepickerを設定
        dateTextField.inputAccessoryView = toolbar //dateTextFieldにtoolbarを追加
    }
    
    //dateTextField toolbarのDoneボタンを押下した時の処理
    @objc func doneClicked(){
        dateTextField.text = dateFormatter.string(from: datePicker.date) // textFieldに選択した日付を代入
        self.view.endEditing(true) // キーボードを閉じる
    }
}

//MARK: - UITextFieldDelegate
extension AddPlanViewController: UITextFieldDelegate {
    //dateTextFieldのみ手入力不可に設定
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
}
