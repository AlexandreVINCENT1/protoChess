//
//  PlayerInfo.swift
//  protoChess
//
//  Created by alexandre VINCENT on 10/05/2024.
//

import Foundation

struct PlayerInfo : Codable {
    let rating: Int
    let result: String
    let playerUrl: String
    let username: String
    enum CodingKeys : String, CodingKey {
        case rating = "rating"
        case result = "result"
        case playerUrl = "@id"
        case username = "username"
    }
}
