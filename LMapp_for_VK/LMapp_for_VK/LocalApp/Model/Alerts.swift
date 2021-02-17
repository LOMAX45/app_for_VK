//
//  Alerts.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 22.12.2020.
//

import UIKit

public func alerting (viewController: UIViewController, title: String, message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    // Создаем кнопку для UIAlertController
    let action = UIAlertAction(title: "ОК", style: .default, handler: nil)
    // Добавляем кнопку на UIAlertController
    alert.addAction(action)
    // Показываем UIAlertController
    viewController.present(alert, animated: true, completion: nil)
}


