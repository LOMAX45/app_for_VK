//
//  NewsCell.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 25.12.2020.
//

import UIKit

class NewsSinglePhotoCell: UITableViewCell {
    
    var index: Int = 0

    @IBOutlet weak var ownerAvatar: UIImageView!
    @IBOutlet weak var ownerNickname: UILabel!
    @IBOutlet weak var creationDate: UILabel!
    @IBOutlet weak var bodyText: UITextView!
    @IBOutlet weak var bodyImage: UIImageView!
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
            guard let i = demoNews[index].likedBy.firstIndex(of: Session.instance.currentUser) else { return }
            demoNews[index].likedBy.remove(at: i)
            likeButton.isSelected = false
            likeButton.tintColor = UIColor.systemGray
            numbersOfLikes.textColor = UIColor.systemGray
            demoNews[index].likes -= 1
            UIView.transition(with: numbersOfLikes,
                              duration: 0.5,
                              options: .transitionFlipFromLeft,
                              animations: {
                                self.numbersOfLikes.text = "\(demoNews[self.index].likes)"
                              },
                              completion: nil)
        } else {
            demoNews[index].likedBy.append(Session.instance.currentUser)
            likeButton.isSelected = true
            likeButton.tintColor = UIColor.systemRed
            numbersOfLikes.textColor = UIColor.systemRed
            demoNews[index].likes += 1
            UIView.transition(with: numbersOfLikes,
                              duration: 0.5,
                              options: .transitionFlipFromLeft,
                              animations: {
                                self.numbersOfLikes.text = "\(demoNews[self.index].likes)"
                              },
                              completion: nil)
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
    
    func setData (owner: User, creationDate: String, bodyText: String, bodyImage: UIImage,numbersOfLikes: UInt, numbersOfComments: UInt, numbersOfReposts: UInt, numbersOfViews: UInt) {
        self.ownerAvatar.image = owner.avatar
        self.ownerNickname.text = owner.nickname
        self.creationDate.text = creationDate
        self.bodyText.text = bodyText
        self.bodyImage.image = bodyImage
        self.numbersOfLikes.text = "\(numbersOfLikes)"
        self.numbersOfComments.text = "\(numbersOfComments)"
        self.numbersOfReposts.text = "\(numbersOfReposts)"
        self.numbersOfViews.text = "\(numbersOfViews)"
    }
    
    func setupLikeButton () {
        if demoNews[index].likedBy.contains(Session.instance.currentUser) {
            likeButton.isSelected = true
            likeButton.tintColor = UIColor.systemRed
            numbersOfLikes.textColor = UIColor.systemRed
        } else {
            likeButton.isSelected = false
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
