//
//  network.swift
//  proto_chess
//
//  Created by alexandre VINCENT on 29/04/2024.
//

import Foundation

class AsyncNetworkManager {
    static let shared = AsyncNetworkManager()
    
    func getUserProfile(username: String) async throws -> UserProfile {
        guard let url = URL(string: "https://api.chess.com/pub/player/" + username) else {
            throw NetworkErrors.invalidURL
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            let decodedData = try decoder.decode(UserProfile.self, from: data)
            return decodedData
        } catch {
            throw NetworkErrors.jsonDecoder
        }
    }
    func getUserGames(username: String) async throws -> [Game] {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY/MM"
            let period = dateFormatter.string(from: Date())
            guard let url = URL(string: "https://api.chess.com/pub/player/\(username)/games/\(period)") else {
                throw NetworkErrors.invalidURL
            }
            let (data, _) = try await URLSession.shared.data(from: url)
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .secondsSince1970
                let decodedData = try decoder.decode(Games.self, from: data)
                return decodedData.games
            } catch {
                throw NetworkErrors.jsonDecoder
            }
        }
    
    func getUserProfileImage(url : String) async throws -> Data {
        guard let url = URL(string: url) else {
            throw NetworkErrors.invalidURL
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
}

enum NetworkErrors: Error {
    case invalidURL
    case serverError
    case jsonDecoder
    case invalidImage
    // Add more error cases as needed
}
