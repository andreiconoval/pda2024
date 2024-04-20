//
//  APIFootballClient.swift
//  teammate
//
//  Created by user256828 on 4/18/24.
//

import Foundation

class APIClient {
    private let baseURL = URL(string: "https://api.football-data.org/v4/")!
    private let token = "bd87a0ad8505478d8514a8b8c1cebd6a"
    
    func fetchTeamData(teamID: Int, completion: @escaping (Result<Team, Error>) -> Void) {
        let teamURL = baseURL.appendingPathComponent("teams/\(teamID)/")
        var request = URLRequest(url: teamURL)
        request.addValue(token, forHTTPHeaderField: "X-Auth-Token")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
                let error = NSError(domain: "HTTP", code: statusCode, userInfo: nil)
                completion(.failure(error))
                return
            }
            
            if let data = data {
                do {
                    let team = try JSONDecoder().decode(Team.self, from: data)
                    completion(.success(team))
                } catch {
                    completion(.failure(error))
                }
            } else {
                let error = NSError(domain: "Data", code: -1, userInfo: nil)
                completion(.failure(error))
            }
        }.resume()
    }
    
    
    func fetchPlayerData(playerID: Int, completion: @escaping (Result<Player, Error>) -> Void) {
        let playerURL = baseURL.appendingPathComponent("persons/\(playerID)/")
        var request = URLRequest(url: playerURL)
        request.addValue(token, forHTTPHeaderField: "X-Auth-Token")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
                let error = NSError(domain: "HTTP", code: statusCode, userInfo: nil)
                completion(.failure(error))
                return
            }
            
            if let data = data {
                do {
                    let player = try JSONDecoder().decode(Player.self, from: data)
                    completion(.success(player))
                } catch {
                    completion(.failure(error))
                }
            } else {
                let error = NSError(domain: "Data", code: -1, userInfo: nil)
                completion(.failure(error))
            }
        }.resume()
    }
}
