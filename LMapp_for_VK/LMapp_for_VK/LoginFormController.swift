//
//  LoginFormControllerViewController.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 08.12.2020.
//

import UIKit

class LoginFormController: UIViewController {

    @IBOutlet weak var nickNameEntInput: UITextField!
    @IBOutlet weak var passwordEntInput: UITextField!
    @IBOutlet weak var scrollingEnt: UIScrollView!
    @IBOutlet weak var nickNameregInput: UITextField!
    @IBOutlet weak var passwordRegInput: UITextField!
    @IBOutlet weak var nameRegInput: UITextField!
    @IBOutlet weak var familyNameRegInput: UITextField!
    @IBOutlet weak var scrollingReg: UIScrollView!
    
    var listOfUsers = [["admin", "admin", "admin", "admin"], ["testuser", "12345", "Test", "User"]]
    
    @IBAction func unwindSegue(sender: UIStoryboardSegue) {}
    
    @IBAction func regButtonPressed(_ sender: Any) {}
    
    @IBAction func enterButtonPressed(_ sender: Any) {}
    
    @IBAction func RegProcess(_ sender: Any) {}
    
    private func alerting (title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                    // Создаем кнопку для UIAlertController
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                    // Добавляем кнопку на UIAlertController
                    alert.addAction(action)
                    // Показываем UIAlertController
                    present(alert, animated: true, completion: nil)
    }
    
    private func checkInputsReg () -> Bool {
        return (nickNameregInput.text != "" && passwordRegInput.text != "" && nameRegInput.text != "" && familyNameRegInput.text != "")
    }
    
    private func checkNickAvailability () -> Bool {
        var i = 0
        while i < listOfUsers.count && nickNameregInput.text != listOfUsers[i][0] {
            i += 1
        }
        if i < listOfUsers.count {
            return false
        } else {
            return true
        }
    }
    
    private func checkLogOnCredentials () -> Bool {
        var i = 0
        while i < listOfUsers.count && nickNameEntInput.text != listOfUsers[i][0] {
            i += 1
        }
        if i < listOfUsers.count {
            return passwordEntInput.text == listOfUsers[i][1]
        } else {
            return false
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        switch identifier {
        case "Registration":
            if !checkNickAvailability() {
                alerting(title: "Ошибка", message: "Пользователь с таким ником уже существует")
                return false
            } else if checkInputsReg() {
                listOfUsers.append([nickNameregInput.text!, passwordRegInput.text!, nameRegInput.text!, familyNameRegInput.text!])
                print(listOfUsers)
                return true
            } else {
                alerting(title: "Ошибка", message: "Все поля должны быть заполнены")
                return false
            }
        case "LogOn":
            if checkLogOnCredentials() {
                return true
            } else {
                alerting(title: "Ошибка", message: "Неверный логин или пароль.")
                return false
            }
        default:
            return true
        }
    }
    

    
    
    // Когда клавиатура появляется на экране входа
    
        @objc func keyboardWasShownEnt(notification: Notification) {
            
            // Получаем размер клавиатуры
            let info = notification.userInfo! as NSDictionary
            let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
            let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
            
            // Добавляем отступ внизу UIScrollView, равный размеру клавиатуры
            self.scrollingEnt?.contentInset = contentInsets
            scrollingEnt?.scrollIndicatorInsets = contentInsets
        }
    
    // Когда клавиатура появляется на экране регистрации
        @objc func keyboardWasShownReg(notification: Notification) {
            
            // Получаем размер клавиатуры
            let info = notification.userInfo! as NSDictionary
            let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
            let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
            
            // Добавляем отступ внизу UIScrollView, равный размеру клавиатуры
            self.scrollingReg?.contentInset = contentInsets
            scrollingReg?.scrollIndicatorInsets = contentInsets
        }

        
        //Когда клавиатура исчезает на экране входа
        @objc func keyboardWillBeHiddenEnt(notification: Notification) {
            // Устанавливаем отступ внизу UIScrollView, равный 0
            let contentInsets = UIEdgeInsets.zero
            scrollingEnt?.contentInset = contentInsets
        }
    
    //Когда клавиатура исчезает на экране регистрации
    @objc func keyboardWillBeHiddenReg(notification: Notification) {
        // Устанавливаем отступ внизу UIScrollView, равный 0
        let contentInsets = UIEdgeInsets.zero
        scrollingReg?.contentInset = contentInsets
    }
    
    @objc func hideKeyboardEnt() {
            self.scrollingEnt?.endEditing(true)
        }
    
    @objc func hideKeyboardReg() {
            self.scrollingReg?.endEditing(true)
        }


    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Подписываемся на два уведомления: одно приходит при появлении клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShownEnt), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShownReg), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        // Второе — когда она пропадает
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHiddenEnt(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHiddenReg(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Жест нажатия
        let hideKeyboardGestureEnt = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardEnt))
        
        let hideKeyboardGestureReg = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardReg))
        
        // Присваиваем его UIScrollVIew
        scrollingEnt?.addGestureRecognizer(hideKeyboardGestureEnt)
        
        scrollingReg?.addGestureRecognizer(hideKeyboardGestureReg)

        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        }
    
    /*
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


