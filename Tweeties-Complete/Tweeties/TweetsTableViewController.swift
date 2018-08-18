//
//  TweetsTableViewController.swift
//  Tweeties
//
//  Created by Duc Tran on 7/27/17.
//  Copyright © 2017 Developers Academy. All rights reserved.
//

import UIKit
import Twitter

class TweetsTableViewController : UITableViewController
{
    private var tweets = [[Tweet]]()
    var searchController:  UISearchController!
    
    var searchText: String? {
        didSet {
            
            searchController?.searchBar.text = searchText
            searchController?.searchBar.placeholder = searchText
            
            tweets.removeAll()
            tableView.reloadData()
            searchForTweets()
        }
    }
    
    private func twitterRequest() -> Request?
    {
        if let queryText = searchText, !queryText.isEmpty {
            return Request(search: queryText, count: 100)
        }
        
        return nil
    }
    
    private var lastTwitterRequest: Request?
    
    private func searchForTweets()
    {
        if let request = twitterRequest() {
            self.lastTwitterRequest = request
            
            request.fetchTweets({ [weak self] (newTweets) in
                DispatchQueue.main.async {
                    if request == self?.lastTwitterRequest {
                        self?.tweets.insert(newTweets, at: 0)
                        self?.tableView.insertSections([0], with: .fade)
                    }
                }
            })
        }
    }
    
    // MARK: - ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        
        searchText = "interior design"
        setupSearchController()
    }
    
    private func setupSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search Twitter"
        
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = true
        searchController.searchBar.delegate = self
        
        navigationItem.titleView = searchController.searchBar
        definesPresentationContext = true
    }
    
    // MARK: - Table View Data Source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return tweets.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetTableViewCell
        let tweet = tweets[indexPath.section][indexPath.row]
        
        cell.tweet = tweet
        cell.selectionStyle = .none
        
        return cell
    }
}

// MARK: - UISearchBarDelegate

extension TweetsTableViewController : UISearchBarDelegate
{
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        if searchBar == searchController.searchBar {
            searchBar.placeholder = "Search Twitter"
        }
        
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar == searchController.searchBar {
            searchText = searchBar.text
            searchController.isActive = false
        }
    }
}



















