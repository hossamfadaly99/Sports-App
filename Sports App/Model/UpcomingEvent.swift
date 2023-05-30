//
//  UpComingEvent.swift
//  Sports App
//
//  Created by Hossam on 20/05/2023.
//

import Foundation
class UpcomingEvent: Decodable{
  public var event_event_key : Int?
  public var event_date : String?
  public var event_time : String?
  public var event_home_team : String?
  public var home_team_home_team_key : Int?
  public var event_away_team : String?
  public var away_team_away_team_key : Int?
  public var event_halftime_result : String?
  public var event_final_result : String?
  public var event_ft_result : String?
  public var event_penalty_result : String?
  public var event_status : String?
  public var country_name : String?
  public var league_name : String?
  public var league_league_key : Int?
  public var league_round : String?
  public var league_season : String?
  public var event_live : String?
  public var event_stadium : String?
  public var event_referee : String?
  public var home_team_logo : String?
  public var away_team_logo : String?
  public var event_country_event_country_key : Int?
  public var league_logo : String?
  public var country_logo : String?
  public var event_home_formation : String?
  public var event_away_formation : String?
  public var fk_stage_fk_stage_key : Int?
  public var stage_name : String?
  public var league_group : String?
  public var goalscorers : Array<Goalscorers>?
  public var substitutes : Array<Substitutes>?
  public var cards : Array<Cards>?
  public var lineups : Lineups?
  public var statistics : Array<Statistics>?
}

public class Goalscorers: Decodable {
  public var time : String?
  public var home_scorer : String?
  public var home_scorer_id : String?
  public var home_assist : String?
  public var home_assist_id : String?
  public var score : String?
  public var away_scorer : String?
  public var away_scorer_id : String?
  public var away_assist : String?
  public var away_assist_id : String?
  public var info : String?
  public var info_time : String?
}

public class Cards: Decodable {
  public var time : String?
  public var home_fault : String?
  public var card : String?
  public var away_fault : String?
  public var info : String?
  public var home_player_id : String?
  public var away_player_id : String?
  public var info_time : String?
}

public class Away_team: Decodable {
  public var starting_lineups : Array<String>?
  public var substitutes : Array<String>?
  public var coaches : Array<String>?
  public var missing_players : Array<String>?
}

public class Away_scorer: Decodable {
  public var inCoding : String?
  public var outCoding : String?
  public var in_id : Int?
  public var out_id : Int?

  enum CodingKeys: String, CodingKey{
    case inCoding = "in"
    case outCoding = "out"
    case in_id = "in_id"
    case out_id = "out_id"
  }
}

public class Home_team: Decodable {
  public var starting_lineups : Array<String>?
  public var substitutes : Array<String>?
  public var coaches : Array<String>?
  public var missing_players : Array<String>?
}

public class Substitutes: Decodable {
  public var time : String?
  public var home_scorer : Array<String>?
  public var home_assist : String?
  public var score : String?
  public var away_scorer : Away_scorer?
  public var away_assist : String?
  public var info : String?
  public var info_time : String?
}

public class Statistics: Decodable {
  public var type : String?
  public var home : String?
  public var away : String?
}

public class Lineups: Decodable {
  public var home_team : Home_team?
  public var away_team : Away_team?
}


