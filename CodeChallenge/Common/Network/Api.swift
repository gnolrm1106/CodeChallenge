//
//  Api.swift
//  CodeChallenge
//
//  Created by Vox Long on 11/12/17.
//  Copyright © 2017 com. All rights reserved.
//

import UIKit
import Alamofire

let apiUrl = "https://newsapi.org"
let apiKey = "521aabcab7bf4e49a414a38cc96704eb"

public protocol TargetType {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
}


public enum API {
    case GetFeeds
}

extension API : TargetType {
    public var baseURL : String {
        return apiUrl
    }
    
    public var path : String {
        switch self {
        case .GetFeeds:
            return "\(baseURL)/v1/articles"

        }
    }
    
    public var method : HTTPMethod {
        switch self {
        case .GetFeeds:
            return HTTPMethod.get
        }
    }
}
