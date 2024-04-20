//
//  PlayerMatchesResult.swift
//  teammate
//
//  Created by user256828 on 4/20/24.
//

import Foundation


struct Filter: Codable {
    let limit: Int
    let offset: Int
    let competitions: String
    let permission: String
}

struct ResultSet: Codable {
    let count: Int
    let competitions: String
    let first: String
    let last: String
}


struct Match: Codable {
  
    let area: Area
    let competition: Competition
    let season: Season
    let id: Int
    let utcDate: String
    let status: String
    let matchday: Int
    let stage: String
    let group: String?
    let lastUpdated: String
    let homeTeam: OverViewTeam
    let awayTeam: OverViewTeam
    let score: Score
    let odds: [String: String]
    let referees: [Referee]
}


struct Season: Codable {
    let id: Int
    let startDate: String
    let endDate: String
    let currentMatchday: Int
    let winner: String?
}

struct OverViewTeam: Codable {
    let id: Int
    let name: String
    let shortName: String
    let tla: String
    let crest: String
}

struct Score: Codable {
    let winner: String
    let duration: String
    let fullTime: [String: Int]
    let halfTime: [String: Int]
}

struct Referee: Codable {
    let id: Int
    let name: String
    let type: String
    let nationality: String
}


struct PlayerMatchesResult: Codable {
    let filters: Filter
    let resultSet: ResultSet
    let aggregations: String
    let matches: [Match]!
}
