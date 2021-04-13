//
//  NetNewsController.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 25.03.2021.
//

import UIKit

class NetNewsController: UIViewController {
    
     @IBOutlet weak var tableView: UITableView!
    var photoService: PhotoService?

    let networkManager = NetworkManager()
    var items:[NewsItem] = []
    let parser = NewsItemsParser()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoService = PhotoService(container: tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "NetNewsPostCell", bundle: nil), forCellReuseIdentifier: "NetNewsPostCell")
        getNews()

    }

    private func getNews() {
        self.networkManager.getJson(method: .getNews) { [weak self] (data) in
            guard let self = self else { return }
            self.parser.parseData(data: data) { [weak self] (items) in
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
        
        cell.setData(ownerNickname: item.sourceName,
                     creationDate: item.date,
                     bodyText: item.text,
                     numbersOfLikes: item.likes.count,
                     numbersOfComments: item.comments.count,
                     numbersOfReposts: item.reposts.count,
                     numbersOfViews: item.views.count)
        cell.ownerAvatar.image = photoService?.photo(atIndexpath: indexPath, byUrl: item.sourceAvatar)
        return cell
    }
    
}

