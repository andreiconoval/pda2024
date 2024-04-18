//
//  Team.swift
//  teammate
//
//  Created by user256828 on 4/18/24.
//

import Foundation

struct Team: Codable {
    let area: Area
    let id: Int
    let name, shortName, tla: String
    let crest, address, website: String
    let founded: Int
    let clubColors, venue: String
    let runningCompetitions: [Competition]
    let coach: Coach
    let squad: [SquadPlayer]
    let staff: [Staff]
    let lastUpdated: String
}

struct Area: Codable {
    let id: Int
    let name, code: String
    let flag: String
}

struct Coach: Codable {
    let id: Int
    let firstName, lastName, name, dateOfBirth: String
    let nationality: String
    let contract: Contract
}

struct Contract: Codable {
    let start, until: String
}

struct Competition: Codable {
    let id: Int
    let name, code, type: String
    let emblem: String?
}

// MARK: - Staff
struct Staff: Codable {
}
