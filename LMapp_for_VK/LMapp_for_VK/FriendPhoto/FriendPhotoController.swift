//
//  FriendPhotoController.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 11.12.2020.
//

import UIKit

class FriendPhotoController: UIViewController {
    
    var photosLibrary:[UIImage] = []
    
    var imageView:ShowPhotoImageView? = nil
    var backgroundView:UIView? = nil
    var closeButton: UIButton? = nil
    
    var index: Int = 0
    var row: Int = 0
    var column: Int = 0
    
    let itemSize = UIScreen.main.bounds.width / 3 - 2
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        
        layout.minimumInteritemSpacing = 3
        layout.minimumLineSpacing = 3
        
        collectionView.collectionViewLayout = layout
        
        let threeDotLoadingIndicator = ThreeDotLoadingIndicator(frame: CGRect(x: self.view.center.x - 20, y: self.view.bounds.maxY - 120, width: 40, height: 10))
        self.view.addSubview(threeDotLoadingIndicator)
        threeDotLoadingIndicator.startAnimation()
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(closeShowPhotoViewBySwipe(_:)))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
        
    }
    
    func showPhoto(selectedPhoto: Int) {
        backgroundView = UIView(frame: CGRect(origin: CGPoint(x: itemSize * CGFloat(column) , y: self.view.safeAreaInsets.bottom + itemSize * CGFloat(row)), size: CGSize(width: itemSize, height: itemSize)))
        backgroundView!.backgroundColor = .black
        backgroundView!.layer.opacity = 0
        self.view.addSubview(backgroundView!)
        
        imageView = ShowPhotoImageView(frame: CGRect(origin: CGPoint(x: itemSize * CGFloat(column) , y: self.view.safeAreaInsets.bottom + itemSize * CGFloat(row)), size: CGSize(width: itemSize, height: itemSize)))
        imageView!.photosLibrary = self.photosLibrary
        imageView!.selectedPhoto = selectedPhoto
        imageView!.setImageView()
        self.view.addSubview(imageView!)
        
        UIView.animate(withDuration: 0.6,
                       delay: 0.0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 1.0,
                       options: [],
                       animations: {
                        self.backgroundView?.frame = self.view.bounds
                        self.backgroundView?.layer.opacity = 0.75
                        self.imageView?.frame = CGRect(x: 0, y: self.view.center.y - self.view.bounds.width / 2, width: self.view.bounds.width, height: self.view.bounds.width)
                        self.imageView?.imageView.frame = self.imageView!.bounds
                       },
                       completion: {_ in
                        self.closeButton = UIButton(type: .custom)
                        self.closeButton!.frame = CGRect(x: self.view.bounds.width - 40, y: 100, width: 30, height: 30)
                        self.closeButton?.setImage(UIImage(named: "closeButton"), for: .normal)
                        self.view.addSubview(self.closeButton!)
                        self.closeButton!.addTarget(self, action: #selector(self.closeShowPhotoView(_:)), for: .touchUpInside)
                       })
    }
    
    @objc private func closeShowPhotoView(_ selector: UIButton) {
        closeAnimation()
    }
    
    @objc private func closeShowPhotoViewBySwipe(_ selector: UISwipeGestureRecognizer) {
        closeAnimation()
    }
    
    func closeAnimation() {
        self.closeButton?.removeFromSuperview()
        
        if self.imageView?.selectedPhoto != nil {
            self.index = (self.imageView?.selectedPhoto)!
        } else { return }
        
        controlPosition(index: self.index)
        
        UIView.animate(withDuration: 0.3,
                       animations: {
                        self.backgroundView?.frame = CGRect(origin: CGPoint(x: self.itemSize * CGFloat(self.column) + 3, y: self.view.safeAreaInsets.top + self.itemSize * CGFloat(self.row) + 3), size: CGSize(width: self.itemSize, height: self.itemSize))
                        self.backgroundView?.alpha = 0
                        
                        self.imageView?.alpha = 0.5
                        self.imageView?.frame = CGRect(origin: CGPoint(x: self.itemSize * CGFloat(self.column) + 3, y: self.view.safeAreaInsets.top + self.itemSize * CGFloat(self.row) + 3), size: CGSize(width: self.itemSize, height: self.itemSize))
                        self.imageView?.imageView.frame = self.imageView!.bounds
                       },
                       completion: {_ in
                        self.imageView?.removeFromSuperview()
                        self.backgroundView?.removeFromSuperview()
                       })
    }
    
    func controlPosition(index: Int) {
        if index < 3 {
            self.row = 0
            self.column = index
        } else {
            self.row = index / 3
            self.column = index % 3
        }
    }
    
    func updateIndex (index: Int) {
        self.index = index
    }
    
}

extension FriendPhotoController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosLibrary.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "friendPhotoCell", for: indexPath) as! FriendPhotoCell
        cell.setData(image: photosLibrary[indexPath.row])
        cell.addLikeControl()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        index = indexPath.row
        controlPosition(index: index)
        
        showPhoto(selectedPhoto: index)
        
    }
    
}
