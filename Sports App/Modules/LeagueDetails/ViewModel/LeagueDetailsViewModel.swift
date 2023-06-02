//
//  LeagueDetailsViiewModel.swift
//  Sports App
//
//  Created by Hossam on 24/05/2023.
//

import Foundation
class LeagueDetailsViewModel{

  let database = DBManager.sharedLeagueDB
  var allDBLeagues: [LocalLeague] = []
  var bindDBToViewController: (()->()) = {}

  var isFavLeague: Bool = false {
    didSet{
      bindDBToViewController()
    }
  }

  var bindResultToViewController: (()->()) = {print("ggggggggggg")}


  var upcomingEventResult: [Event]? = []
  {
    didSet{
      bindResultToViewController()
    }
  }

  var latestEventResult: [Event]? = []
  {
    didSet{
      bindResultToViewController()
    }
  }

  var teams: [Team]? = []
  {
    didSet{
      bindResultToViewController()
    }
  }

  enum EventType{
    case upcoming
    case latest
  }

  func getAllData(sportName: String, leagueId: String){
    let upcomingBlock = BlockOperation{
      self.getUpcomingEvent(sportName: sportName, leagueId: leagueId, startDate: Constants.currentDate, endDate: Constants.nextYear, eventType: .upcoming)
    }
    let latestBlock = BlockOperation{
      self.getUpcomingEvent(sportName: sportName, leagueId: leagueId, startDate: Constants.previousYear, endDate: Constants.currentDate, eventType: .latest)
    }
    let teamsBlock = BlockOperation{
      self.getTeams(sportName: sportName, leagueId: leagueId)
    }



//    print(upcomingEventResult?.count)
//    print(latestEventResult?.count)
//    print(teams?.count)

//    self.upcomingEventResult = upcomingEventInitResult
    bindResultToViewController()

  }

   func getUpcomingEvent(sportName: String, leagueId: String, startDate: String, endDate: String, eventType: EventType){


    let url = "https://apiv2.allsportsapi.com/\(sportName)/"
    let parameters = ["met" : "Fixtures", "leagueId" : leagueId, "from" : startDate, "to" : endDate, "APIkey" : Constants.API_KEY]


      NetworkManager().fetchData(url: url, param: parameters){ [weak self] (response : MyResult<Event>?) in
        if( eventType == .upcoming){
          self?.upcomingEventResult = response?.result
      }
        else{
          self?.latestEventResult = response?.result
        }
    }
  }


   func getTeams(sportName: String, leagueId: String){

    let url = "https://apiv2.allsportsapi.com/\(sportName)/"
    let parameters = ["met" : "Teams", "leagueId" : leagueId, "APIkey" : Constants.API_KEY]

      NetworkManager().fetchData(url: url, param: parameters){ [weak self] (response : MyResult<Team>?) in
          self?.teams = response?.result
    }
  }

  func insertFavLeague(league: LocalLeague){
    let newLeague = LocalLeague(leagueName: league.leagueName, leagueImage: league.leagueImage, leagueId: league.leagueId, sportName: league.sportName)
    database.insert(newLeague: newLeague)
    isFavLeague = true
  }

  func deleteFavLeague(leagueId: Int){
    for (index, item) in allDBLeagues.enumerated(){
      if item.leagueId == leagueId{
        database.delete(id: index)
        break
      }
    }
    isFavLeague = false
  }

  func isFavLeague(leagueId: Int){
    allDBLeagues =  database.getAllLeagues() ?? []
    var isFav = false
    for item in allDBLeagues{
      if item.leagueId == leagueId{
        isFav = true
        break
      }
    }
    isFavLeague = isFav
  }



}
