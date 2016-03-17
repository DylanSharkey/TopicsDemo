//
//  Topic.swift
//  votes
//
//  Created by Dylan Sharkey on 3/17/16.
//  Copyright © 2016 Dylan Sharkey. All rights reserved.
//

import Foundation
import RealmSwift

class Topic: Object {
    dynamic var name: String?
    dynamic var votes: Int = 0
}
