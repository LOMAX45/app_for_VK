//
//  UrlRequestsController.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 02.02.2021.
//

import UIKit
import WebKit

class UrlRequestsController: UIViewController {

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
    
    @IBOutlet weak var searchGroupsButton: UIButton!
    @IBAction func searchGroups(_ sender: Any) {
        
        let networkmanger = NetworkManager()
        networkmanger.getData(method: .searchGroups) { (data) in
            print(data)
            
            DispatchQueue.main.async {
                alerting(viewController: self, title: "ГОТОВО !!!", message: "Первые 5 групп по поисковому запросу были выведены в консоль.")
            }
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }


}
