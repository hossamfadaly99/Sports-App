//
//  AllSportsViewModel.swift
//  Sports App
//
//  Created by Hossam on 21/05/2023.
//

import Foundation
class LeaguesViewModel{
  var bindResultToViewController: (()->()) = {}

  var result: [AllLeagues]? = [] {
    didSet{
      bindResultToViewController()
    }
  }
  
  func getItems(sportName: String){

    let url = "https://apiv2.allsportsapi.com/\(sportName)/"
    let parameters = ["met" : "Leagues", "APIkey" : Constants.API_KEY]

    NetworkManager().fetchData(url: url, param: parameters){ [weak self] (response : MyResult<AllLeagues>?) in

      self?.result = response?.result

    }
  }

}
