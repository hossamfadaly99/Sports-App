//
//  TeamDetailsViewModel.swift
//  Sports App
//
//  Created by Hossam on 30/05/2023.
//

import Foundation
class TeamDetailsViewModel{

  var bindResultToViewController: (()->()) = {}

  var team: Team?  {
    didSet{
      bindResultToViewController()
    }
  }

  func getTeamDetails(sportName: String, teamId: String){
    print("kjnkjrbktnb")
    print(teamId)

    let url = "https://apiv2.allsportsapi.com/\(sportName)/"
    let parameters = ["met" : "Teams", "teamId" : teamId, "APIkey" : Constants.API_KEY]


      NetworkManager().fetchData(url: url, param: parameters){ [weak self] (response : MyResult<Team>?) in
          self?.team = response?.result?[0]
    }
  }
}
