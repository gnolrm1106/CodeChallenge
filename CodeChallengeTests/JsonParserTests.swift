//
//  JsonParserTests.swift
//  CodeChallengeTests
//
//  Created by Vox Long on 11/12/17.
//  Copyright © 2017 com. All rights reserved.
//

import XCTest
@testable import CodeChallenge
@testable import SwiftyJSON

class JsonParserTests: XCTestCase {
    
    var results : Array<Article>!
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        //let bundle = Bundle(for: JsonParserTests.self)
        let bundle = Bundle(for: type(of: self))
        let path = bundle.url(forResource: "feeds", withExtension: "json")
        XCTAssertNotNil(path);
        do {
            // Initialize Data With Contents of URL
            let data = try Data(contentsOf: path!)
            XCTAssertNotNil(data);
            
            let service = GetFeedsService()
            results = service.parseResponse(json: JSON(data))
       
        } catch {
            XCTFail("can not find data")
        }
       
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testJson() {
        XCTAssertTrue(results.count == 10, "Number of Article is correct")
    
        // get first object
        let firstArticles = results[0]
        XCTAssertTrue(firstArticles.author == "BBC Sport", "author correct")
        XCTAssertTrue(firstArticles.title == "Wales cut Wallaby lead, Ireland extend advantage v SA", "title correct")
        XCTAssertTrue(firstArticles.description == "Watch, listen and follow live text as Wales host Australia and Ireland face South Africa after wins for England and Scotland.", "description correct")
        XCTAssertTrue(firstArticles.url == "http://www.bbc.co.uk/sport/live/rugby-union/41525310", "url correct")
        XCTAssertTrue(firstArticles.urlToImage == "https://m.files.bbci.co.uk/modules/bbc-morph-sport-opengraph/1.1.1/images/bbc-sport-logo.png", "image url correct")
        XCTAssertTrue(firstArticles.publishedAt == "2017-11-11T17:56:59Z", "timestamp correct")
    }
    
    
}
