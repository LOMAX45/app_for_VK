//
//  NewsItemsParser.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 05.04.2021.
//

import Foundation

class NewsItemsParser {
    private var items:[NewsItem] = []
    private var profiles:[UserVK] = []
    private var groups:[GroupProperties] = []
    private var syncQueue = DispatchQueue(label: "NewsItemParserQueue", attributes: .concurrent, target: DispatchQueue.global(qos: .background))
    
    func parseData(data: Data, completion: @escaping ([NewsItem]) -> ()) {
        var news: NewsJson
        do {
            news = try JSONDecoder().decode(NewsJson.self, from: data)
        } catch {
            news = NewsJson(response: NewsResponse(items: [], profiles: [], groups: []))
            print(error)
        }
        items = news.response.items
        groups = news.response.groups
        profiles = news.response.profiles
        
        let dispatchGroup = DispatchGroup()
        for i in 0..<items.count {
            DispatchQueue.global().async(group: dispatchGroup) { [weak self] in
                guard let self = self else { return }
                self.mergeItem(at: i)
            }
        }
        dispatchGroup.notify(queue: DispatchQueue.main) { [weak self] in
            guard let self = self else { return }
            completion(self.getItems())
        }
    }
    
    func getItems() -> [NewsItem] {
        var localItems: [NewsItem] = []
        syncQueue.sync {
            localItems = items
        }
        return localItems
    }
    
    func mergeItem(at index: Int) {
        syncQueue.async(flags: .barrier) { [weak self] in
            guard let self = self else { return }
            let item = self.items[index]
            let isGroup = item.sourceId < 0
            if isGroup {
                let group = self.groups.first(where: { $0.id == -item.sourceId })
                self.items[index].sourceName = group?.name ?? ""
                self.items[index].sourceAvatar = group?.photo50 ?? ""
            } else {
                let profile = self.profiles.first(where: { $0.id == item.sourceId })
                self.items[index].sourceName = "\(profile?.firstName ?? "") \(profile?.lastName ?? "")"
                self.items[index].sourceAvatar = profile?.avatar ?? ""
            }
        }
    }
}
