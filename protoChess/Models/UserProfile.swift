//
//  UserProfile.swift
//  protoChess
//
//  Created by alexandre VINCENT on 01/05/2024.
//

import Foundation

struct UserProfile : Codable {
    let avatar: String?
    let username: String
    let urlProfile: String
    let joined: Date
    let lastOnline: Date
    let playerId: Int
    enum CodingKeys : String, CodingKey {
        case avatar = "avatar"
        case username = "username"
        case urlProfile = "url"
        case joined = "joined"
        case lastOnline = "last_online"
        case playerId = "player_id"
    }
}
