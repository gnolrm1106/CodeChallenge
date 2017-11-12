//
//  AppStringStyle.swift
//  CodeChallenge
//
//  Created by Vox Long on 11/12/17.
//  Copyright © 2017 com. All rights reserved.
//

import UIKit


class AppString: NSAttributedString {
    class func stringWithAttributed(string : String, font : UIFont, color : UIColor) -> NSAttributedString {
        let attributes = [NSAttributedStringKey.font: font,
                          NSAttributedStringKey.foregroundColor: color]
        return NSAttributedString(string: string, attributes: attributes)
    }
}
