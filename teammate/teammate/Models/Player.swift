//
//  Player.swift
//  teammate
//
//  Created by user256828 on 4/20/24.
//

import Foundation

struct Player: Codable {
    let id: Int
    let name: String
    let firstName: String
    let lastName: String
    let dateOfBirth: String
    let nationality: String
    let section: String
    let position: String
    let shirtNumber: Int
    let lastUpdated: String
    let currentTeam: Team!
}
	
