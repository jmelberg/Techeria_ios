//
//  Models.swift
//  Techeria_iOS
//
//  Created by Jordan Melberg on 5/2/15.
//
//

import Foundation

class User: NSObject{
    var username: NSObject!
    var friendCount: NSObject!
    var picture: NSObject!
    var account_type: NSObject!
    var firstName: NSObject!
    var lastName: NSObject!
    var subScriptions: [NSObject]!
    var email: NSObject!
    var profession: NSObject!
    var employer: NSObject!
}

class Forum: NSObject{
    var author: NSObject!
    var forum: NSObject!
    var reference: NSObject!
    var text: NSObject!
    var type: NSObject!
    var url: NSObject!
    var votes: NSObject!
}

class Feed: NSObject{
    var forum_posts: NSArray!
    var size: NSInteger!
}