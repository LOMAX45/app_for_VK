//
//  NetNewsPostCell.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 24.03.2021.
//

import UIKit

class NetNewsPostCell: UITableViewCell {
    
    let networkManager = NetworkManager()
    
    @IBOutlet weak var ownerAvatar: UIImageView! {
        didSet {
            ownerAvatar.layer.cornerRadius = 32
            ownerAvatar.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var ownerNickname: UILabel!
    @IBOutlet weak var creationDate: UILabel!
    @IBOutlet weak var bodyText: UITextView!
    
    @IBOutlet weak var actionsStack: UIStackView!
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var numbersOfLikes: UILabel!
    
    @IBOutlet weak var commentsButton: UIButton!
    @IBOutlet weak var numbersOfComments: UILabel!
    
    @IBOutlet weak var repostsButton: UIButton!
    @IBOutlet weak var numbersOfReposts: UILabel!
    
    @IBOutlet weak var viewsButton: UIButton!
    @IBOutlet weak var numbersOfViews: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func unixDateToString(date: Int) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = "HH:mm dd/MM/yyyy"
        return dateFormatter.string(from: NSDate(timeIntervalSince1970: TimeInterval(date)) as Date)
    }
    
    func setData(ownerAvatar:String, ownerNickname:String, creationDate: Int, bodyText:String, numbersOfLikes: Int, numbersOfComments: Int, numbersOfReposts: Int, numbersOfViews: Int) {
        
        networkManager.getImage(by: ownerAvatar) { (image) in
            DispatchQueue.main.async {
                if let ownerAvatar = image as UIImage? {
                    self.ownerAvatar.image = ownerAvatar
                }
            }
        }
        
        self.ownerNickname.text = ownerNickname
        self.creationDate.text = unixDateToString(date: creationDate)
        self.bodyText.text = bodyText
        self.numbersOfLikes.text = String(numbersOfLikes)
        self.numbersOfComments.text = String(numbersOfComments)
        self.numbersOfReposts.text = String(numbersOfReposts)
        self.numbersOfViews.text = String(numbersOfViews)
        
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
