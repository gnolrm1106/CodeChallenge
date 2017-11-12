//
//  Network.swift
//  CodeChallenge
//
//  Created by Vox Long on 11/12/17.
//  Copyright © 2017 com. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

// Alias Handler defines
typealias NetworkStartHandler = ()->()
typealias NetworkErrorHandler = (NSError)->()
typealias NetworkFishHandler  = (Any, Int?)->()

typealias ServiceFail = (NSError)->()
typealias ServiceFinish = (Any?) -> ()
typealias NetworkOffline = () -> ()

class Network: NSObject {
    let kNetworkTimeout: TimeInterval = 30.0
    
    var request_id : Int?
    var start : NetworkStartHandler?
    var error : NetworkErrorHandler?
    var finish : NetworkFishHandler?
    var request : Request?
    var api : API!
    var requestEncoding : ParameterEncoding = URLEncoding.default
    var parameters : [String : Any]?
    var headers : [String : String]?
    
    func setStartHandler(start : @escaping NetworkStartHandler) {
        self.start = start
        
    }
    
    func setErrorHandler(error : @escaping NetworkErrorHandler) {
        self.error = error
        
    }
    
    func setFinishHandler(finish : @escaping NetworkFishHandler) {
        self.finish = finish
        
    }
    
    //MARK: normal request
    func requestApi(api : API, parameters : [String : Any]?, encoding : ParameterEncoding?, headers : [String : String]?) {
        
        //sessionConfiguration()
        
        self.api = api
        self.parameters = parameters
        self.headers = headers
        if let enc = encoding {
            self.requestEncoding = enc
        }
        //start request
        start?()
        
        request = Alamofire.request(api.path, method: api.method , parameters: parameters, encoding: self.requestEncoding, headers: headers).validate(contentType: ["application/json"]).responseJSON(completionHandler: { (response : DataResponse<Any>) in
            switch response.result {
            case .success(let json):
                self.finish?(json, response.response?.statusCode)
            case .failure(let error):
                print(error)
                self.error?(error as NSError)
            }
        })
    }
    
    
    //MARK: prepare
    private func queryStringFromDictionary(parameters : [String : AnyObject]) -> String  {
        
        var parts : Array<String> = [String]()
        
        for (key,value) in parameters {
            let part : String = String(format: "%@=%@", key,value.description)
            parts.append(part)
        }
        let joinedString =  (parts as NSArray).componentsJoined(by: "&")
        return joinedString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlPathAllowed)!
    }
    
    //Public funcs
    func cancel() {
        request?.cancel()
    }
}

private extension String {
    var URLEscapedString: String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)!
    }
}
