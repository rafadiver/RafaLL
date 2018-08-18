//
//  TweetTableViewCell.swift
//  Tweeties
//
//  Created by Duc Tran on 7/27/17.
//  Copyright © 2017 Developers Academy. All rights reserved.
//

import UIKit
import Twitter

class TweetTableViewCell : UITableViewCell
{
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var handleAndCreatedAtLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var tweetImageView: UIImageView!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    
    var tweet: Tweet? { didSet { updateUI() } }
    
    private func updateUI()
    {
        tweetTextLabel?.text = tweet?.text
        fullNameLabel?.text = tweet?.user.name
        
        if let created = tweet?.created {
            let formatter = DateFormatter()
            if Date().timeIntervalSince(created) > 24*60*60 {
                formatter.dateStyle = .short
            } else {
                formatter.timeStyle = .short
            }
            let createdText = formatter.string(from: created)
            handleAndCreatedAtLabel?.text = "@\(tweet!.user.screenName) • \(createdText)"
        } else {
            handleAndCreatedAtLabel?.text = "@\(tweet!.user.screenName)"
        }
        
        if let profileImageURL = tweet?.user.profileImageURL {
            let request = URLRequest(url: profileImageURL)
            let networkProcessor = NetworkProcessing(request: request)
            networkProcessor.downloadData(completion: { [weak self] (imageData, httpResponse, error) in
                
                DispatchQueue.main.async {
                    if let imageData = imageData {
                        self?.profileImageView.image = UIImage(data: imageData)
                        self?.profileImageView.roundedCorners()
                    }
                }
            })
        } else {
            profileImageView?.image = nil
        }
        
        if let mediaItem = tweet?.media {
            if let mediaURL = mediaItem.first?.url {
                let request = URLRequest(url: mediaURL)
                let networkProcessor = NetworkProcessing(request: request)
                networkProcessor.downloadData(completion: { [weak self] (imageData, response, error) in
                    
                    DispatchQueue.main.async {
                        if let imageData = imageData {
                            self?.tweetImageView.image = UIImage(data: imageData)
                            self?.tweetImageView.roundedCorners()
                        }

                    }
                })
            } else {
                tweetImageView?.image = nil
                defaultTweetImageViewHeightConstraint = tweetImageViewHeightConstraint.constant
                tweetImageViewHeightConstraint.constant = 0
                layoutIfNeeded()
            }
        } else {
            tweetImageView?.image = nil
            defaultTweetImageViewHeightConstraint = tweetImageViewHeightConstraint.constant
            tweetImageViewHeightConstraint.constant = 0
            layoutIfNeeded()
        }
    }
    
    // MARK: - Dynamic Cell Height for Tweet with/without image
    @IBOutlet weak var tweetImageViewHeightConstraint: NSLayoutConstraint!
    private var defaultTweetImageViewHeightConstraint: CGFloat!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        if tweetImageViewHeightConstraint != nil && defaultTweetImageViewHeightConstraint != nil {
            tweetImageViewHeightConstraint.constant = defaultTweetImageViewHeightConstraint
        }
    }
    
    
}

private extension UIView
{
    func roundedCorners() {
        self.layer.cornerRadius = 5.0
        layer.masksToBounds = true
    }
}


















