//
//  NewsMultiPhotoCell.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 27.12.2020.
//

import UIKit

class NewsMultiPhotoCell: UITableViewCell {
    
    var index: Int = 0

    @IBOutlet weak var ownerAvatar: UIImageView!
    @IBOutlet weak var ownerNickname: UILabel!
    @IBOutlet weak var creationDate: UILabel!
    @IBOutlet weak var bodyText: UITextView!
    @IBOutlet weak var bodyImage1: UIImageView!
    @IBOutlet weak var bodyImage2: UIImageView!
    @IBOutlet weak var bodyImage3: UIImageView!
    @IBOutlet weak var bodyImage4: UIImageView!
    @IBOutlet weak var actionsStack: UIStackView!
    
    @IBOutlet weak var likeButton: UIButton! {
        didSet {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .selected)
            likeButton.scalesLargeContentImage = true
        }
        
    }
    
    @IBAction func likeButtonTapped(_ sender: UIButton) {

        if likeButton.isSelected == true {
            guard let i = demoNews[index].likedBy.firstIndex(of: currentUser) else { return }
            demoNews[index].likedBy.remove(at: i)
            likeButton.isSelected = false
            likeButton.tintColor = UIColor.systemGray
            numbersOfLikes.textColor = UIColor.systemGray
            demoNews[index].likes -= 1
            numbersOfLikes.text = "\(demoNews[index].likes)"
        } else {
            demoNews[index].likedBy.append(currentUser)
            likeButton.isSelected = true
            likeButton.tintColor = UIColor.systemRed
            numbersOfLikes.textColor = UIColor.systemRed
            demoNews[index].likes += 1
            numbersOfLikes.text = "\(demoNews[index].likes)"
        }
    }
    @IBOutlet weak var numbersOfLikes: UILabel!
    
    @IBOutlet weak var commentsButton: UIButton!
    @IBOutlet weak var numbersOfComments: UILabel!
    
    @IBOutlet weak var repostsButton: UIButton!
    @IBOutlet weak var numbersOfReposts: UILabel!
    
    @IBOutlet weak var viewsButton: UIButton!
    @IBOutlet weak var numbersOfViews: UILabel!
    
    func getIndex (index: Int) {
        self.index = index
    }
    
    func setData (owner: User, creationDate: String, bodyText: String, bodyImages: [UIImage],numbersOfLikes: UInt, numbersOfComments: UInt, numbersOfReposts: UInt, numbersOfViews: UInt) {
        self.ownerAvatar.image = owner.avatar
        self.ownerNickname.text = owner.nickname
        self.creationDate.text = creationDate
        self.bodyText.text = bodyText
        self.bodyImage1.image = bodyImages[0]
        self.bodyImage2.image = bodyImages[1]
        self.bodyImage3.image = bodyImages[2]
        self.bodyImage4.image = bodyImages[3]
        self.numbersOfLikes.text = "\(numbersOfLikes)"
        self.numbersOfComments.text = "\(numbersOfComments)"
        self.numbersOfReposts.text = "\(numbersOfReposts)"
        self.numbersOfViews.text = "\(numbersOfViews)"
    }
    
    func setupLikeButton () {
        if demoNews[index].likedBy.contains(currentUser) {
            likeButton.isSelected = true
            likeButton.tintColor = UIColor.systemRed
            numbersOfLikes.textColor = UIColor.systemRed
        } else {
            likeButton.isSelected = false
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
