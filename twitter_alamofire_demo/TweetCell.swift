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
    
    var tweet: Tweet! {
        didSet {
            tweetLabel.text = tweet.text
            profileImageView.af_setImage(withURL: tweet.user.profileImage!)
            nameLabel.text = tweet.user.name
            screennameLabel.text = tweet.user.screenName
            dateLabel.text = tweet.createdAtString
            let retweetString = "\(tweet.retweetCount)"
            retweetsLabel.text = retweetString
            let favoritesString = "\(String(tweet.favoriteCount))"
            favoritesLabel.text = favoritesString
            id = tweet.id
        }
    }
    
    @IBAction func favoriteTweet(_ sender: UIButton) {
        if (sender.isSelected) {
            sender.isSelected = false
            APIManager.shared.unfavorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let error = error {
                    print("Error unfavoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unfavorited the following Tweet: \n\(tweet.text)")
                }
            }
            tweet.favoriteCount -= 1
        } else {
            sender.isSelected = true
            APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                }
            }
            tweet.favoriteCount += 1
        }
        favoritesLabel.text = String(tweet.favoriteCount)
    }
    
    @IBAction func retweetTweet(_ sender: UIButton) {
        if (sender.isSelected) {
            sender.isSelected = false
            APIManager.shared.unretweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let error = error {
                    print("Error unretweeting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unretweeting the following Tweet: \n\(tweet.text)")
                }
            }
            tweet.retweetCount -= 1
        } else {
            sender.isSelected = true
            APIManager.shared.retweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let error = error {
                    print("Error retweeting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully retweeting the following Tweet: \n\(tweet.text)")
                }
            }
            tweet.retweetCount += 1
        }
        retweetsLabel.text = String(tweet.retweetCount)
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
