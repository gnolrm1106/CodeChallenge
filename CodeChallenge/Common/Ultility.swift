//
//  Ultility.swift
//  CodeChallenge
//
//  Created by Vox Long on 11/12/17.
//  Copyright © 2017 com. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class Ultility: NSObject {
    class func setTitleForViewController(viewController : ASViewController<ASDisplayNode>, title : String) {
            let titleNode = UILabel()
            titleNode.frame = CGRect(x: 0, y: 0, width: 200, height: 44)
            titleNode.textAlignment = .center
            titleNode.attributedText = AppString.stringWithAttributed(string: title, font: UIFont.boldSystemFont(ofSize: 14), color: UIColor.white)
            viewController.navigationItem.titleView = titleNode
        }
    
    class func convertTimestampToDisplayString(timestamp : String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.timeZone = TimeZone.current
        guard let date = dateFormatter.date(from: timestamp) else {
            return ""
        }
        
        let displayDateFormatter = DateFormatter()
        displayDateFormatter.dateFormat = "EEEE, MMMM dd, yyyy"
        return displayDateFormatter.string(from: date)
    }
}
