//
//  Comment.swift
//  StepsChallenge
//
//  Created by dreams on 1/9/19.
//  Copyright © 2019 Steps. All rights reserved.
//

import UIKit

class Comment: NSObject {
    var id = 0
    var postId = 0
    var name = ""
    var email = ""
    var body = ""
    
    override init() {
        
    }
    
    init(dict:[String:Any]) {
        if let val = dict["id"] as? Int                      { id = val }
        if let val = dict["postId"] as? Int               { postId = val }
        if let val = dict["name"] as? String               { name = val }
        if let val = dict["email"] as? String      { email = val}
        if let val = dict["body"] as? String      { body = val}
    }
}
