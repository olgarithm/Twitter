//
//  ProfileViewController.swift
//  twitter_alamofire_demo
//
//  Created by Olga Andreeva on 7/6/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var numberTweetsLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    var tweets: [Tweet] = []
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        user = User.current!
        let numberTweetsString = String(user.tweets!)
        numberTweetsLabel.text = numberTweetsString
        followingLabel.text = String(user.following!)
        followersLabel.text = String(user.followers!)
        profileImageView.af_setImage(withURL: user.profileImage!)
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2;
        profileImageView.layer.masksToBounds = true
        backgroundImageView.af_setImage(withURL: user.backgroundImage!)
        nameLabel.text = user.name
        usernameLabel.text = "@" + user.screenName!
        getMyTweets()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
    }
    
    func getMyTweets() {
        print("getting my tweets")
        APIManager.shared.getMyTweets(user.screenName!) { (tweets, error) in
            if let tweets = tweets {
                self.tweets = tweets
                self.tableView.reloadData()
            } else if let error = error {
                print("Error getting my tweets: " + error.localizedDescription)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTweetCell", for: indexPath) as! TweetCell
        
        cell.tweet = tweets[indexPath.row]
        cell.profileImageView.layer.cornerRadius = 5
        cell.profileImageView.layer.masksToBounds = true
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
