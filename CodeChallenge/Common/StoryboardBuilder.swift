//
//  StoryboardBuilder.swift
//  CodeChallenge
//
//  Created by Vox Long on 11/12/17.
//  Copyright © 2017 com. All rights reserved.
//

import UIKit

class StoryboardBuilder: NSObject {
    static let sharedInstance = StoryboardBuilder()
    lazy var Main = UIStoryboard(name: "Main", bundle: Bundle.main)
    private override init() {}
    
    func detailViewController() -> DetailViewController {
        return Main.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
    }
}
