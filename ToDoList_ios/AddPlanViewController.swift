//
//  AddPlanViewController.swift
//  ToDoList_ios
//
//  Created by 中野勇貴 on 2021/03/09.
//

import UIKit
import UITextView_Placeholder
import MaterialComponents.MaterialButtons
import RealmSwift

class AddPlanViewController: UIViewController {
    
    @IBOutlet weak var titleBgView: UIView!
    @IBOutlet weak var contentBgView: UIView!
    @IBOutlet weak var dateBgView: UIView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var addPlanBtn: MDCFloatingButton!
    let realm = try! Realm() //realm
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
    
        //addPlanBtn
        addPlanBtn.inkColor = UIColor.white // 押下した時の色を指定
        addPlanBtn.inkStyle = .bounded // 押下した時の動きを指定
        addPlanBtn.isEnabled = false // 初期状態ではボタンを押下できないように設定
        
        //各テキスト入力フォームの背景ViewにcornerRadiusを設定
        titleBgView.layer.cornerRadius = titleBgView.frame.height / 3
        contentBgView.layer.cornerRadius = contentBgView.frame.height / 8
        dateBgView.layer.cornerRadius = dateBgView.frame.height / 3
        
        //titleTextFieldのplaceholderを設定
        titleTextField.attributedPlaceholder = NSAttributedString(string: "デートの題名"
                                                                  , attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(named: C.Colors.gray)!])
        
        //contentTextViewのplaceholderを設定
        contentTextView.placeholder = "行く場所・やることなど"
        contentTextView.placeholderColor = UIColor.init(named: C.Colors.gray)
        
        //dateTextFieldのplaceholderを設定
        dateTextField.attributedPlaceholder = NSAttributedString(string: "yyyy/mm/dd"
                                                                 , attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(named: C.Colors.gray)!])
        
        dateTextField.delegate = self
        titleTextField.delegate = self
        
        //dateTextFieldにdatepickerを設定
        dateTextField.inputView = datePicker // textFieldのinputViewにdatepickerを設定
        dateTextField.inputAccessoryView = toolbar //dateTextFieldにtoolbarを追加
        
        setUpNotificationForTextField() //キーボード系処理実行
        
    }
    
    //dateTextField toolbarのDoneボタンを押下した時の処理
    @objc func doneClicked(){
        dateTextField.text = dateFormatter.string(from: datePicker.date) // textFieldに選択した日付を代入
        self.view.endEditing(true) // キーボードを閉じる
    }
    
    @IBAction func addPlanBtnPressed(_ sender: Any) {
        //newPlanを作成
        let newPlan = Plan()
        newPlan.title = titleTextField.text ?? ""
        newPlan.content = contentTextView.text
        if dateTextField.text != "未定" && dateTextField.text != "" {
            //TODO: - 未定も入れられるように後日対応
            newPlan.date = DateUtils.dateFromString(string: dateTextField.text!, format: "yyyy/MM/dd")
        }
        
        //DBにデータを保存
        RealmUtils.saveData(with: newPlan)
        
        //Home画面に遷移
        let homeView = storyboard?.instantiateViewController(identifier: C.homeViewId) as! HomeViewController
        self.present(homeView, animated: true, completion: nil)
    }
}

//MARK: - UITextFieldDelegate
extension AddPlanViewController: UITextFieldDelegate {
    //dateTextFieldのみ手入力不可に設定
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == dateTextField {
            return false
        }
        
        return true
    }
    
    //titleTextField・dateTextFieldに文字が入力されていなければaddPlanBtnを無効にする
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let titleIsEmpty = titleTextField.text?.isEmpty ?? true
        let dateIsEmpty = dateTextField.text?.isEmpty ?? true
        if !titleIsEmpty && !dateIsEmpty{
            addPlanBtn.isEnabled = true
        } else {
            addPlanBtn.isEnabled = false
        }
    }
    
    //キーボードのEnterを押下するとキーボードが閉じる
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

//MARK: - キーボード系の処理 キーボードが出てきた時viewを移動させる
extension AddPlanViewController {
    //キーボード・テキストフィールド以外のところをタッチするとキーボードを閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func setUpNotificationForTextField() {
        let notificationCenter = NotificationCenter.default
        //キーボードが出る時に呼ばれる
        notificationCenter.addObserver(self, selector: #selector(self.keyboardWillShow(_ :)),
                                       name:UIResponder.keyboardWillShowNotification, object: nil)
        //キーボードが隠れる時に呼ばれる
        notificationCenter.addObserver(self, selector: #selector(self.keyboardWillHide(_ :)),
                                       name:UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //キーボードが出てきた時の処理
    @objc func keyboardWillShow(_ notification: Notification) {
        let keyboardFrame = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
        guard let keyboardMinY = keyboardFrame?.minY else { return }
        let btnMaxY = addPlanBtn.frame.maxY
        let distance = btnMaxY - keyboardMinY + 60
        let transform = CGAffineTransform(translationX: 0, y: -distance)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [], animations: {
            self.view.transform = transform
        })
    }
    
    //キーボードが隠れた時の処理
    @objc func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [], animations: {
            self.view.transform = .identity
        })
    }
}
