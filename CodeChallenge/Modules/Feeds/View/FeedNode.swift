//
//  FeedNode.swift
//  CodeChallenge
//
//  Created by Vox Long on 11/12/17.
//  Copyright © 2017 com. All rights reserved.
//

import UIKit
import AsyncDisplayKit
class FeedNode: ASCellNode {
    var imageNode : ASNetworkImageNode = ASNetworkImageNode()
    var titleNode : ASTextNode = ASTextNode()
    var descriptionNode : ASTextNode = ASTextNode()
    var timestampNode : ASTextNode = ASTextNode()
    var article : Article!
    
    init(article : Article) {
        super.init()
        self.article = article
        configureImageNode()
        configureTitleNode()
        configureDescriptionNode()
        configureTimeStampNode()
    }
    
    private func configureImageNode() {
        imageNode.style.preferredSize = CGSize(width: 100, height: 100)
        imageNode.contentMode = .scaleAspectFill
        imageNode.shouldCacheImage = true
        if let url = article.urlToImage {
            imageNode.url = URL(string: url)
        }
        addSubnode(imageNode)
    }
    
    private func configureTitleNode() {
        titleNode.maximumNumberOfLines = 2
       
        titleNode.truncationMode = .byTruncatingTail
        if let title = article.title {
            titleNode.attributedText = AppString.stringWithAttributed(string: title, font: UIFont.boldSystemFont(ofSize: 14), color: UIColor.black)
        }
        addSubnode(titleNode)
    }
    
    private func configureDescriptionNode() {
        descriptionNode.maximumNumberOfLines = 3
        descriptionNode.truncationMode = .byTruncatingTail
        if let des = article.description {
            descriptionNode.attributedText = AppString.stringWithAttributed(string: des, font: UIFont.systemFont(ofSize: 14), color: UIColor.black)
        }
        addSubnode(descriptionNode)
    }
    
    private func configureTimeStampNode() {
        timestampNode.maximumNumberOfLines = 1
        timestampNode.truncationMode = .byTruncatingTail
        if let timestamp = article.publishedAt {
            let timeString = Ultility.convertTimestampToDisplayString(timestamp: timestamp)
            timestampNode.attributedText = AppString.stringWithAttributed(string: timeString, font: UIFont.systemFont(ofSize: 11), color: UIColor.lightGray)
        }
        addSubnode(timestampNode)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let rightStackLayout = ASStackLayoutSpec(direction: .vertical, spacing: 10, justifyContent: .start, alignItems: .start, children: [titleNode, descriptionNode, timestampNode])
        rightStackLayout.style.flexGrow = 1.0
        rightStackLayout.style.flexShrink = 1.0
        let mainStackLayout = ASStackLayoutSpec(direction: .horizontal, spacing: 10, justifyContent: .start, alignItems: .start, children: [imageNode, rightStackLayout])
        let mainInsetLayout = ASInsetLayoutSpec(insets: UIEdgeInsetsMake(10, 10, 10, 10), child: mainStackLayout)
        return mainInsetLayout
    }
}
