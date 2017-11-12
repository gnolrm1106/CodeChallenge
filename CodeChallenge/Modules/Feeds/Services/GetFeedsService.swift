//
//  GetFeedsService.swift
//  CodeChallenge
//
//  Created by Vox Long on 11/12/17.
//  Copyright © 2017 com. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class GetFeedsService: NSObject {
   
    override init() {}
    
    func start(source : String, sortBy : String, apiKey : String, fail : @escaping ServiceFail, finish : @escaping ServiceFinish, offline : @escaping NetworkOffline) {
        //check internet connection first
        if (!Connectivity.isConnectedToInternet()) {
            offline()
            return
        }
        
        //create network object
        let network = Network()
        network.setStartHandler {
            
        }
        
        network.setFinishHandler { (response : Any, statusCode : Int?) in
            print("Vote service : \(String(describing: response))  code : \(String(describing: statusCode))")
                let articles = self.parseResponse(json: JSON(response))
                finish(articles)
        }
        
        network.setErrorHandler { (error : NSError) in
            print("Vote Serivce : \(error)")
            fail(error)
        }
        
        let parameters = ["source" : source, "sortBy" : sortBy, "apiKey" : apiKey];
        network.requestApi(api: .GetFeeds, parameters: parameters, encoding: URLEncoding.default, headers: nil)
    }
    
    func parseResponse(json : JSON) -> Array<Article> {
        var results = Array<Article>()
        if let articles = json["articles"].array {
            for article in articles {
                var articleObj = Article();
                articleObj.author = article["author"].string;
                articleObj.description = article["description"].string;
                articleObj.publishedAt = article["publishedAt"].string;
                articleObj.title = article["title"].string;
                articleObj.url = article["url"].string;
                articleObj.urlToImage = article["urlToImage"].string
                results.append(articleObj)
            }
        }
        return results;
    }
}
