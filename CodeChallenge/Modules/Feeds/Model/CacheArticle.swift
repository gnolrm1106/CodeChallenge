//
//  CacheArticle.swift
//  CodeChallenge
//
//  Created by Vox Long on 11/12/17.
//Copyright © 2017 com. All rights reserved.
//

import Foundation
import RealmSwift

class CacheArticle: Object {
    @objc dynamic var author : String? = nil
    @objc dynamic var article_description: String? = nil
    @objc dynamic var publishedAt : String? = nil
    @objc dynamic var title : String? = nil
    @objc dynamic var url : String? = nil
    @objc dynamic var urlToImage : String? = nil
}

extension CacheArticle {
    convenience init(object: Article) {
        self.init()
        author = object.author
        article_description = object.description
        publishedAt = object.publishedAt
        title = object.title
        url = object.url
        urlToImage = object.urlToImage
    }
}
