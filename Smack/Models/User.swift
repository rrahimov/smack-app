//
//  User.swift
//  Smack
//
//  Created by Ruhullah Rahimov on 23.01.21.
//

// Codable, Encodable, Decodable

struct User: Decodable {
    var user: String?
    var token: String?
    var avatarColor: String?
    var avatarName: String?
    var email: String?
    var name: String?
    var id: String?
}
