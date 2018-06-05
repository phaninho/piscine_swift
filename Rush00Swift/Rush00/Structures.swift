//
//  Structures.swift
//  Rush00
//
//  Created by Benedetta DAL CANTON on 6/2/18.
//  Copyright © 2018 Benedetta DAL CANTON. All rights reserved.
//

import Foundation

struct Access: Codable {
    var access_token: String
}

struct Author: Codable {
    var login: String
    var id: Int
}

struct MessContent: Codable {
    var markdown: String
}

struct TopicMessage: Codable {
    var id: Int
    var content: MessContent
}

struct Topic: Codable {
    var id: Int
    var name: String
    var author: Author
    var created_at: String
    var updated_at: String
    var message: TopicMessage
}

//struct Topic {
//    var name: String
//}

struct Message: Codable {
    var id: Int
    var content: String
    var author: Author
    var created_at: String
    var updated_at: String
    var replies: [Message]
    var parent_id: Int?
}

struct Me: Codable {
    var id: Int
}
