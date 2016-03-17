//
//  tableDelegate.swift
//  votes
//
//  Created by Dylan Sharkey on 3/17/16.
//  Copyright © 2016 Dylan Sharkey. All rights reserved.
//

import Foundation

protocol tableDelegate: class {
    func upVotePressed(cell: AnyObject)
    func downVotePressed(cell: AnyObject)
}