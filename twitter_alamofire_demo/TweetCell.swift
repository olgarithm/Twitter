//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Olga Andreeva on 6/18/17.
//  Copyright © 2017 Olga Andreeva. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var retweetsLabel: UILabel!
    @IBOutlet weak var favoritesLabel: UILabel!
    var id: Int64!
    
    @IBAction func favoriteTweet(_ sender: UIButton) {
        let priorFavorites = Int(favoritesLabel.text!)
        if (sender.isSelected) {
            sender.isSelected = false
            APIManager.shared.unfavorite(tweetID: id) 
            favoritesLabel.text = String(priorFavorites! - 1)
        } else {
            sender.isSelected = true
            APIManager.shared.favorite(tweetID: id)
            favoritesLabel.text = String(priorFavorites! + 1)
        }
    }
    
    @IBAction func retweetTweet(_ sender: UIButton) {
        let priorRetweets = Int(retweetsLabel.text!)
        if (sender.isSelected) {
            sender.isSelected = false
            APIManager.shared.unretweet(tweetID: id)
            retweetsLabel.text = String(priorRetweets! - 1)
        } else {
            sender.isSelected = true
            APIManager.shared.retweet(tweetID: id)
            retweetsLabel.text = String(priorRetweets! + 1)
        }
    }
    
    var tweet: Tweet! {
        didSet {
            tweetLabel.text = tweet.text
            profileImageView.af_setImage(withURL: tweet.user.profileImage!)
            nameLabel.text = tweet.user.name
            screennameLabel.text = tweet.user.screenName
            dateLabel.text = tweet.createdAtString
            let retweetString = "\(tweet.retweetCount)"
            retweetsLabel.text = retweetString
            let favoritesString = "\(String(tweet.favoriteCount!))"
            favoritesLabel.text = favoritesString
            id = tweet.id
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
