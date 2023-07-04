//
//  FavoriteViewModel.swift
//  Sports App
//
//  Created by Hossam on 31/05/2023.
//

import Foundation
class FavoriteViewModel{

  let database = DBManager.sharedLeagueDB

  var bindDBToViewController: (()->()) = {}

  var allDBLeagues: [LocalLeague] = [] {
    didSet{
      bindDBToViewController()
    }
  }

  func deleteFavLeague(leagueId: Int){
    getAllFavLeagues()
    for (index, item) in allDBLeagues.enumerated(){
      if item.leagueId == leagueId{
        database.delete(id: index)
        break
      }
    }
//    isFavLeague = false
    getAllFavLeagues()
  }

  func getAllFavLeagues(){
      allDBLeagues =  database.getAllLeagues() ?? []
  }
}
