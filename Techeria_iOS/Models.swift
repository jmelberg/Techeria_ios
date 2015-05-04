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
    var author: String!
    var forum: String!
    var reference: String!
    var text: String!
    var title: String!
    var type: String!
    var url: String!
    var votes: Int!
}

class Message: NSObject{
    var type: String!
    var sender: String!
    var recipient: String!
    var text: String!
}
