//
//  PhotoServise.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 12.04.2021.
//

import UIKit
import Alamofire

class PhotoService {
    
    private static let cacheLifeTime: TimeInterval = 24 * 60 * 60
    private static let pathName: String = {
        
        let pathName = "images"
        
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return pathName }
        let url = cachesDirectory.appendingPathComponent(pathName, isDirectory: true)
        
        if !FileManager.default.fileExists(atPath: url.path) {
            try? FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        }
        
        return pathName
    }()
    
    private func getFilePath(url: String) -> String? {
        
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil }
        
        let hashName = url.split(separator: "/").last ?? "default"
        return cachesDirectory.appendingPathComponent(PhotoService.pathName + "/" + hashName).path
    }
    
    private class func isFileObsolete(path: String) -> Bool {
        guard let info = try? FileManager.default.attributesOfItem(atPath: path),
              let modificationDate = info[FileAttributeKey.modificationDate] as? Date
        else { return true }
        
        let lifeTime = Date().timeIntervalSince(modificationDate)
        
        return lifeTime > cacheLifeTime
    }
    
    private func saveImageToCache(url: String, image: UIImage) {
        guard let fileName = getFilePath(url: url),
              let data = image.pngData() else { return }
        FileManager.default.createFile(atPath: fileName, contents: data, attributes: nil)
    }
    
    private func getImageFromCache(url: String) -> UIImage? {
        guard
            let fileName = getFilePath(url: url),
            !PhotoService.isFileObsolete(path: fileName),
            let image = UIImage(contentsOfFile: fileName) else { return nil }
        
        DispatchQueue.main.async { [weak self] in
            self?.images[url] = image
        }
        return image
    }
    
    
    private var images = [String: UIImage]()
    
    private func loadPhoto(atIndexpath indexPath: IndexPath, byUrl url: String) {
        AF.request(url).responseData(queue: DispatchQueue.global()) { [weak self] response in
            guard
                let data = response.data,
                let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                self?.images[url] = image
            }
            self?.saveImageToCache(url: url, image: image)
            DispatchQueue.main.async {
                self?.container.reloadRow(atIndexpath: indexPath)
            }
        }
    }
    
    func photo(atIndexpath indexPath: IndexPath, byUrl url: String) -> UIImage? {
        var image: UIImage?
        if let photo = images[url] {
            image = photo
        } else if let photo = getImageFromCache(url: url) {
            image = photo
        } else {
            loadPhoto(atIndexpath: indexPath, byUrl: url)
        }
        return image
    }
    
    private class func getImagesFolderPath() -> String? {
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil }
        return cachesDirectory.appendingPathComponent(PhotoService.pathName).path
    }
    
    class func clearObsoleteImages() throws {
        guard let imagesFolderPath = getImagesFolderPath() else { return }
        print("imagesFolderPath: \(imagesFolderPath)")
        let cachedImages = try FileManager.default.contentsOfDirectory(atPath: imagesFolderPath)
        let dispatchGroup = DispatchGroup()
        DispatchQueue.global().async(group: dispatchGroup) {
            for cachedImage in cachedImages {
                let imagePath = imagesFolderPath + "/" + cachedImage
                if isFileObsolete(path: imagePath) {
                    try? FileManager.default.removeItem(atPath: imagePath)
                }
            }
        }
    }
    
    private let container: DataReloadable
    
    init(container: UITableView) {
        self.container = Table(table: container)
    }
    
    init(container: UICollectionView) {
        self.container = Collection(collection: container)
    }
    
    
}

fileprivate protocol DataReloadable {
    func reloadRow(atIndexpath indexPath: IndexPath)
}

extension PhotoService {
    
    private class Table: DataReloadable {
        let table: UITableView
        
        init(table: UITableView) {
            self.table = table
        }
        
        func reloadRow(atIndexpath indexPath: IndexPath) {
            table.reloadRows(at: [indexPath], with: .none)
        }
        
    }
    
    private class Collection: DataReloadable {
        let collection: UICollectionView
        
        init(collection: UICollectionView) {
            self.collection = collection
        }
        
        func reloadRow(atIndexpath indexPath: IndexPath) {
            collection.reloadItems(at: [indexPath])
        }
    }
}
