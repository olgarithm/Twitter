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
