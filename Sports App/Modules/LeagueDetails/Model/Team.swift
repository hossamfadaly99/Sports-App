//
//  Team.swift
//  Sports App
//
//  Created by Hossam on 30/05/2023.
//

import Foundation
struct Team: Decodable {
    let team_key: Int?
    let team_name: String?
    let team_logo: String?
    let players: [Player]?
    let coaches: [Coach]?
}

// MARK: - Coach
struct Coach: Decodable {
    let coach_name: String?

}

// MARK: - Player
struct Player: Decodable {
    let player_key: Int?
    let player_name, player_number: String?
    let player_type: String?
    let player_age, player_matchPlayed, player_goals, player_yellow_cards: String?
    let player_red_cards: String?
    let player_image: String?

}

struct PlayerType: Decodable {
    let Defenders, Forwards, Goalkeepers, Midfielders: String?

}


