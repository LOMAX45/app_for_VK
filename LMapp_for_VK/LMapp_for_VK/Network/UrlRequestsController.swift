//
//  UrlRequestsController.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 02.02.2021.
//

import UIKit
import WebKit


class UrlRequestsController: UIViewController {
    
    //Переменная для значения высоты клавиатуры
    var keyboardHeight: CGFloat = 0
    
    @IBOutlet weak var friendsListButton: UIButton!
    @IBAction func getFriendList(_ sender: Any) {
        let networkManager = NetworkManager()
        networkManager.getData(method: .getFriends) { (data) in
            print(data)
            
            DispatchQueue.main.async {
                alerting(viewController: self, title: "ГОТОВО !!!", message: "Список друзей был выведен в консоль.")
            }
        }
    }
    
    @IBOutlet weak var photoLibraryButton: UIButton!
    @IBAction func getPhotos(_ sender: Any) {
        let networkmanger = NetworkManager()
        networkmanger.getData(method: .getPhotos) { (data) in
            print(data)
            
            DispatchQueue.main.async {
                alerting(viewController: self, title: "ГОТОВО !!!", message: "Фотографии были выведены в консоль.")
            }
        }
    }
    
    @IBOutlet weak var groupsListButton: UIButton!
    @IBAction func getGroupsList(_ sender: Any) {
        let networkmanger = NetworkManager()
        networkmanger.getData(method: .getGroupsList) { (data) in
            print(data)
            
            DispatchQueue.main.async {
                alerting(viewController: self, title: "ГОТОВО !!!", message: "Список групп текущего пользователя был выведен в консоль.")
            }
        }
    }
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchGroupsButton: UIButton!
    @IBAction func searchGroups(_ sender: Any) {
        if searchTextField.text != "" {
            let networkmanger = NetworkManager()
            networkmanger.searchText = searchTextField.text!
            networkmanger.getData(method: .searchGroups) { (data) in
                print(data)
                
                DispatchQueue.main.async {
                    alerting(viewController: self, title: "ГОТОВО !!!", message: "Первые 5 групп по поисковому запросу были выведены в консоль.")
                }
            }
        } else {
            DispatchQueue.main.async {
                alerting(viewController: self, title: "НЕЧЕГО ИСКАТЬ !", message: "Введите поисковый запрос в текстое поле.")
            }
        }
    }
    
    
    @IBAction func goToLocalApp(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "LoggedOnController")
        show(controller, sender: nil)
    }
    
    @IBOutlet weak var topViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomViewConstraint: NSLayoutConstraint!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Подписываемся на уведомление о пояилении клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        // Подписываемся на уведомление о скрытии клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        //Добавляем распознаватель нажатия для скрытия клавиатуры
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        self.view.addGestureRecognizer(tap)
        
    }
    
    //Фукция, которая поднимает контент при появлении клавиатуры
    @objc func keyboardWillAppear(_ notification: Notification?) {
        if let keyboardFrame: NSValue = notification?.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            keyboardHeight = keyboardRectangle.height
            
            UIView.animate(withDuration: 0.3) {
                self.moveUpView(to: self.keyboardHeight)
                self.view.layoutIfNeeded()
            }
        }
    }
    
    //Фукция скрытия клавиатуры
    @objc func tapAction() {
        view.endEditing(true)
    }
    
    //Функция, которая возвращает контент во время скрытия клавиатуры
    @objc func keyboardWillDisappear(_ notification: Notification?) {
        
        UIView.animate(withDuration: 0.3) {
            self.topViewConstraint.constant = self.view.safeAreaInsets.top
            self.bottomViewConstraint.constant = self.view.safeAreaInsets.bottom
            self.view.layoutIfNeeded()
        }
    }
    
    func moveUpView(to height: CGFloat) {
        topViewConstraint.constant = -height
        bottomViewConstraint.constant = -height
    }
    
    //Отписываемся от уведомлений
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
}
