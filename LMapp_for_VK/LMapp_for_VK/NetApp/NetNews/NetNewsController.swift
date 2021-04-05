//
//  NetNewsController.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 25.03.2021.
//

import UIKit

class NetNewsController: UIViewController {
    
     @IBOutlet weak var tableView: UITableView!

    let networkManager = NetworkManager()
    var items:[NewsItem] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "NetNewsPostCell", bundle: nil), forCellReuseIdentifier: "NetNewsPostCell")
        getNews()

    }

    private func getNews() {
        self.networkManager.getJson(method: .getNews) { [weak self] (data) in
            NewsItemsParser().parseData(data: data) { (items) in
                guard let self = self else { return }
                self.items = items
                self.tableView.reloadData()
            }
        }
    }
}
    
extension NetNewsController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NetNewsPostCell", for: indexPath) as! NetNewsPostCell
        
        let item = items[indexPath.row]
        
        cell.setData(ownerAvatar: item.sourceAvatar,
                     ownerNickname: item.sourceName,
                     creationDate: item.date,
                     bodyText: item.text,
                     numbersOfLikes: item.likes.count,
                     numbersOfComments: item.comments.count,
                     numbersOfReposts: item.reposts.count,
                     numbersOfViews: item.views.count)
        
        return cell
    }
    
}

