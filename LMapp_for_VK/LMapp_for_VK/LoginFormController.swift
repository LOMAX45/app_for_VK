//
//  LoginFormController.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 08.12.2020.
//


import UIKit

class LoginFormController: UIViewController {

    @IBOutlet weak var nickNameEntInput: UITextField!
    @IBOutlet weak var passwordEntInput: UITextField!
    @IBOutlet weak var scrollingEnt: UIScrollView!
    
    @IBOutlet weak var nickNameRegInput: UITextField!
    @IBOutlet weak var passwordRegInput: UITextField!
    @IBOutlet weak var nameRegInput: UITextField!
    @IBOutlet weak var familyNameRegInput: UITextField!
    @IBOutlet weak var scrollingReg: UIScrollView!
    
    var listOfUsers = [
        ["admin", "admin", "admin", "admin"],
        ["testuser", "12345", "Test", "User"]
    ]
    
    @IBAction func unwindSegue(sender: UIStoryboardSegue) {}
    @IBAction func regButtonPressed(_ sender: Any) {}
    @IBAction func enterButtonPressed(_ sender: Any) {}
    
    private func alerting (title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        // Создаем кнопку для UIAlertController
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        // Добавляем кнопку на UIAlertController
        alert.addAction(action)
        // Показываем UIAlertController
        present(alert, animated: true, completion: nil)
    }
    
    private func checkInputsFilling () -> Bool {
        return (nickNameRegInput.text != "" && passwordRegInput.text != "" && nameRegInput.text != "" && familyNameRegInput.text != "")
    }
    
    private func checkAvailabilityOfNick (nick: UITextField) -> Int {
        var i = 0
        while i < listOfUsers.count && nick.text != listOfUsers[i][0] {
            i += 1
        }
        return i
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        switch identifier {
        case "Registration":
            if !checkInputsFilling() {
                alerting(title: "ОШИБКА", message: "Все поля должны быть заполнены")
                return false
            } else if checkAvailabilityOfNick(nick: nickNameRegInput) < listOfUsers.count {
                alerting(title: "ОШИБКА", message: "Пользователь с таким ником уже существует.")
                return false
            } else {
                listOfUsers.append([nickNameRegInput.text!, passwordRegInput.text!, nameRegInput.text!, familyNameRegInput.text!])
                print(listOfUsers)
                return true
            }
        case "LogOn":
            if checkAvailabilityOfNick(nick: nickNameEntInput) < listOfUsers.count {
                let checkPass = passwordEntInput.text == listOfUsers[checkAvailabilityOfNick(nick: nickNameEntInput)][1]
                if checkPass == false {
                    alerting(title: "ОШИБКА", message: "Вы ввели неверный пароль")
                    return false
                } else {
                    return true
                }
            } else {
                alerting(title: "ОШИБКА", message: "Пользователя с таким ником не существует")
                return false
            }
        default:
            return true
        }
    }
    
    // Когда клавиатура появляется на экране входа
    @objc func keyboardWasShown(notification: Notification) {
        
        // Получаем размер клавиатуры
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        
        // Добавляем отступ внизу UIScrollView, равный размеру клавиатуры
        self.scrollingEnt?.contentInset = contentInsets
        scrollingEnt?.scrollIndicatorInsets = contentInsets
        
        self.scrollingReg?.contentInset = contentInsets
        scrollingReg?.scrollIndicatorInsets = contentInsets
    }
        
    //Когда клавиатура исчезает на экране входа
    @objc func keyboardWillBeHidden(notification: Notification) {
        // Устанавливаем отступ внизу UIScrollView, равный 0
        let contentInsets = UIEdgeInsets.zero
        scrollingEnt?.contentInset = contentInsets
        scrollingReg?.contentInset = contentInsets
    }
    
    @objc func hideKeyboard() {
        self.scrollingEnt?.endEditing(true)
        self.scrollingReg?.endEditing(true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Подписываемся на два уведомления: одно приходит при появлении клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        // Второе — когда она пропадает
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Жест нажатия
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        // Присваиваем его UIScrollVIew
        scrollingEnt?.addGestureRecognizer(hideKeyboardGesture)
        scrollingReg?.addGestureRecognizer(hideKeyboardGesture)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        }
}
