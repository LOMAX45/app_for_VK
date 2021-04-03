//
//  FriendPhotoController.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 19.02.2021.
//

import UIKit
import RealmSwift

class FriendPhotoController: UIViewController {
    
    var id:Int = 0
    var urlsDict = [String]()
    var photoImages: [UIImage] = []
    var photoCache: [UIImage] = []
    var photosLibrary: [ItemRealm]?
    let database = UsersDB()
    let networkManager = NetworkManager()
    
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
        
        getFriendPhoto(id: self.id)
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        
        layout.minimumInteritemSpacing = 3
        layout.minimumLineSpacing = 3
        
        collectionView.collectionViewLayout = layout
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(closeShowPhotoViewBySwipe(_:)))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
        
        
    }
    
    private func getFriendPhoto(id:Int) {
        
        let realmDB = UsersDB()
        
        networkManager.getData(method: .getPhotos, id: id) { [weak self] (response) in
            guard let self = self else { return }
            let dispatchGroup = DispatchGroup()
            DispatchQueue.global().async(group: dispatchGroup) {
                response.items.forEach { (item) in
                    let itemRealm = ItemRealm(albumId: item.albumId,
                                              date: item.date,
                                              id: item.id,
                                              ownerId: item.ownerId,
                                              hasTags: item.hasTags,
                                              text: item.text)
                    let sizes = itemRealm.sizes
                    for i in 0..<item.sizes.count {
                        let sizeRealm = SizeRealm(height: item.sizes[i].height,
                                                  url: item.sizes[i].url,
                                                  type: item.sizes[i].type,
                                                  width: item.sizes[i].width)
                        sizes.append(sizeRealm)
                    }
                    DispatchQueue.main.async {
                        realmDB.write(itemRealm)
                    }
                }
            }
            dispatchGroup.notify(queue: DispatchQueue.main) { [self] in
                self.photosLibrary = realmDB.read(id)
                if let photosCount = self.photosLibrary?.count {
                    for _ in 0..<photosCount {
                        self.photoImages.append(UIImage(named: "robot")!)
                    }
                }
                self.collectionView.reloadData()
                self.urlsDict = []
                self.photosLibrary?.forEach({ [self] (item) in
                    self.urlsDict.append(self.getUrl(item: item))
                })
                self.loadingPhotos(urls: self.urlsDict)
            }
        }
    }
    
    private func loadingPhotos(urls: [String]) {
        self.photoCache = []
        let dispatchGroup = DispatchGroup()
        DispatchQueue.global().async(group: dispatchGroup) {
            urls.forEach { (url) in
                self.networkManager.getImage(by: url) { (image) in
                    if let image = image as UIImage? {
                        self.photoCache.append(image)
                    }
                }
            }
        }
        dispatchGroup.notify(queue: DispatchQueue.main) {
            self.photoImages = self.photoCache
            self.collectionView.reloadData()
        }
    }
    
    func showPhoto(selectedPhoto: Int) {
        backgroundView = UIView(frame: CGRect(origin: CGPoint(x: itemSize * CGFloat(column) , y: self.view.safeAreaInsets.bottom + itemSize * CGFloat(row)), size: CGSize(width: itemSize, height: itemSize)))
        backgroundView!.backgroundColor = .black
        backgroundView!.layer.opacity = 0
        self.view.addSubview(backgroundView!)
        
        imageView = ShowPhotoImageView(frame: CGRect(origin: CGPoint(x: itemSize * CGFloat(column) , y: self.view.safeAreaInsets.bottom + itemSize * CGFloat(row)), size: CGSize(width: itemSize, height: itemSize)))
        imageView!.photosLibrary = self.photosLibrary
        //        imageView!.photosLibraryA = self.photosLibraryA
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
    
    private func getUrl(item: ItemRealm) -> String{
        var urlStr = ""
        let sizes = item.sizes
        if let size = sizes.first(where: { (size) -> Bool in
            size.type == "m"
        }) {
            urlStr = size.url
        } else if let size = sizes.first(where: { (size) -> Bool in
            size.type == "s"
        }) {
            urlStr = size.url
        } else {
            let size = sizes[0]
            urlStr = size.url
        }
        return urlStr
    }
    
}

extension FriendPhotoController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = photosLibrary?.count {
            return count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "friendPhotoCell", for: indexPath) as! FriendPhotoCell
        cell.setData(image: photoImages[indexPath.row])
        cell.addLikeControl()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        index = indexPath.row
        controlPosition(index: index)
        //        showPhoto(selectedPhoto: index)
        
    }
    
}

