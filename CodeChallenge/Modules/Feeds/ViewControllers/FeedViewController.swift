//
//  FeedViewController.swift
//  CodeChallenge
//
//  Created by Vox Long on 11/12/17.
//  Copyright © 2017 com. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import RealmSwift

class FeedViewController: ASViewController<ASDisplayNode> {

    var refreshControl : UIRefreshControl!
    var tableNode : ASTableNode!
    var articles = Array<Article>() {
        didSet {
            DispatchQueue.main.async {
                self.tableNode.reloadData()
            }
        }
    }
    
    override init(node: ASDisplayNode) {
        super.init(node: node)
    }
    
    init() {
        let node = ASTableNode()
        super.init(node: node)
        tableNode = node
        tableNode.dataSource = self
        tableNode.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: ViewController Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        customizeUI()
        getFeeds()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func customizeUI() {
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.getFeeds), for: .valueChanged)
        tableNode.view.refreshControl = refreshControl
        
        Ultility.setTitleForViewController(viewController: self, title: NSLocalizedString("News", comment: ""))
        
    }
    
    //MARK: request
    @objc func getFeeds() {
        let service = GetFeedsService()
        service.start(source: "bbc-sport",
                      sortBy: "top",
                      apiKey: apiKey,
                      fail: { (error : NSError) in
            //show alert if needed
            self.stopRefreshControl()
                        
        }, finish: { (response : Any?) in
            self.articles = response as! Array<Article>
            // do cache here
            self.cacheFeeds(feeds: self.articles)
            self.stopRefreshControl()
        }) {
            self.loadCache()
            self.stopRefreshControl()
        }
    }
    
    func cacheFeeds(feeds : Array<Article>) {
        let cacheService = FeedCacheService()
        cacheService.cacheFeeds(feeds: feeds)
    }
    
    func loadCache() {
        let cacheService = FeedCacheService()
        self.articles = cacheService.getCachedFeeds();
    }
    
    func stopRefreshControl() {
        DispatchQueue.main.async {
            if let refresher = self.refreshControl {
                refresher.endRefreshing()
            }
        }
    }
    
}

extension FeedViewController: ASTableDataSource, ASTableDelegate {
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        let node = FeedNode(article: articles[indexPath.row])
        return node;
    }
    
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        let article = articles[indexPath.row]
        if let url = article.url {
            let detailViewController = StoryboardBuilder.sharedInstance.detailViewController()
            detailViewController.url = url
            self.navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
}
