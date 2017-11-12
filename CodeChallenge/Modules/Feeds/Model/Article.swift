//
//  Article.swift
//  CodeChallenge
//
//  Created by Vox Long on 11/12/17.
//  Copyright © 2017 com. All rights reserved.
//

import UIKit

struct Article {
    var author : String?
    var description: String?
    var publishedAt : String?
    var title : String?
    var url : String?
    var urlToImage : String?
}

extension Article {
    init(object : CacheArticle) {
        author = object.author
        description = object.article_description
        publishedAt = object.publishedAt
        title = object.title
        url = object.url
        urlToImage = object.urlToImage
    }
}
