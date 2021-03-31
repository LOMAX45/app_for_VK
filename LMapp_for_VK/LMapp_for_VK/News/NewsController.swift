//
//  NewsController.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 25.12.2020.
//

import UIKit

class NewsController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "NewsSinglePhotoCell", bundle: nil), forCellReuseIdentifier: "newsSinglePhotoCell")
        
        tableView.register(UINib(nibName: "NewsMultiPhotoCell", bundle: nil), forCellReuseIdentifier: "newsMultiPhotoCell")

    }

}

extension NewsController: UITableViewDelegate, UITableViewDataSource {



    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return demoNews.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let index = indexPath.row
        
        if demoNews[index].pictures.count >= 4 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "newsMultiPhotoCell", for: indexPath) as! NewsMultiPhotoCell
            
            
            let owner = demoNews[index].owner
            let creationDate = demoNews[index].creationDate
            let bodyText = demoNews[index].body
            let bodyImage = demoNews[index].pictures
            let numbersOfLikes = demoNews[index].likes
            let numbersOfComments = demoNews[index].numbersOfComments
            let numbersOfReposts = demoNews[index].reposts
            let numbersOfViews = demoNews[index].views
            
            cell.getIndex(index: indexPath.row)
            
            cell.setData(owner: owner, creationDate: creationDate, bodyText: bodyText, bodyImages: bodyImage, numbersOfLikes: numbersOfLikes, numbersOfComments: numbersOfComments, numbersOfReposts: numbersOfReposts, numbersOfViews: numbersOfViews)
            
            cell.setupLikeButton()
            
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "newsSinglePhotoCell", for: indexPath) as! NewsSinglePhotoCell
            
            
            let owner = demoNews[index].owner
            let creationDate = demoNews[index].creationDate
            let bodyText = demoNews[index].body
            let bodyImage = demoNews[index].pictures[Int.random(in: 0..<demoNews[index].pictures.count)]
            let numbersOfLikes = demoNews[index].likes
            let numbersOfComments = demoNews[index].numbersOfComments
            let numbersOfReposts = demoNews[index].reposts
            let numbersOfViews = demoNews[index].views
            
            cell.getIndex(index: indexPath.row)
            
            cell.setData(owner: owner, creationDate: creationDate, bodyText: bodyText, bodyImage: bodyImage, numbersOfLikes: numbersOfLikes, numbersOfComments: numbersOfComments, numbersOfReposts: numbersOfReposts, numbersOfViews: numbersOfViews)
            
            cell.setupLikeButton()
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
