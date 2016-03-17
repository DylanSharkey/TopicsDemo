//
//  topicCell.swift
//  votes
//
//  Created by Dylan Sharkey on 3/17/16.
//  Copyright © 2016 Dylan Sharkey. All rights reserved.
//

import UIKit

class topicCell: UITableViewCell {
    var delegate: tableDelegate?
    
    @IBOutlet weak var topicLabel: UILabel!
    @IBOutlet weak var numVotesLabel: UILabel!
    
    @IBAction func downVote(sender: UIButton) {
        delegate?.downVotePressed(self)
    }
    @IBAction func upVote(sender: UIButton) {
        delegate?.upVotePressed(self)
    }
}
