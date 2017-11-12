//
//  FeedCacheService.swift
//  CodeChallenge
//
//  Created by Vox Long on 11/12/17.
//  Copyright © 2017 com. All rights reserved.
//

import UIKit
import RealmSwift
class FeedCacheService: NSObject {
    private let realm: Realm
    init(realm: Realm = try! Realm()) {
        self.realm = realm
    }
    
    func cacheFeeds(feeds : Array<Article>) {
        // clear contents first
        realm.beginWrite()
        realm.delete(realm.objects(CacheArticle.self))
        try! realm.commitWrite()
        for feed in feeds {
            let cacheObject = CacheArticle(object: feed)
            try! realm.write {
                realm.add(cacheObject)
            }
        }
    }

    func getCachedFeeds() -> Array<Article> {
        var results = Array<Article>()
        for object in realm.objects(CacheArticle.self) {
            let article = Article(object: object)
            results.append(article)
        }
        return results;
    }
}
