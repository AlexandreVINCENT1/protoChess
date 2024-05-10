//
//  Games.swift
//  protoChess
//
//  Created by alexandre VINCENT on 01/05/2024.
//

import Foundation

struct Game : Codable, Equatable {
    static func == (lhs: Game, rhs: Game) -> Bool {
        return lhs.uuid == rhs.uuid
    }
    
    let black: PlayerInfo
    let endTime: Date
    let mode: String
    let url: String
    let uuid: String
    let white: PlayerInfo
    enum CodingKeys : String, CodingKey {
        case black = "black"
        case endTime = "end_time"
        case mode = "time_class"
        case url = "url"
        case uuid = "uuid"
        case white = "white"
    }
}

struct Games : Codable {
    let games: [Game]
}
