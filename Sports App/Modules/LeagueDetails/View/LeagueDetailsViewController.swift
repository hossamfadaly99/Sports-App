//
//  LeagueDetailsViewController.swift
//  Sports App
//
//  Created by Hossam on 24/05/2023.
//

import UIKit

class LeagueDetailsViewController: UIViewController {

  var indicator: UIActivityIndicatorView!
  var sportName:String = ""
  var leagueId:Int = 0
  var dataFetchedCounter = 0

  var viewModel: LeagueDetailsViewModel!

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    indicator = UIActivityIndicatorView(style: .large)
    indicator.center = self.view.center
    self.view.addSubview(indicator)
    indicator.startAnimating()
  }

    override func viewDidLoad() {
        super.viewDidLoad()



      viewModel = LeagueDetailsViewModel()
      
      viewModel.getUpcomingEvent(sportName: "football", leagueId: "\(leagueId)", startDate: Constants.currentDate, endDate: Constants.nextYear, eventType: .upcoming)

      viewModel.getUpcomingEvent(sportName: "football", leagueId: "\(leagueId)", startDate: Constants.previousYear, endDate: Constants.currentDate, eventType: .latest)


      viewModel.bindResultToViewController = { [weak self] in
        self?.dataFetchedCounter += 1

        DispatchQueue.main.async {

//          self?.tableview.reloadData()

//          self?.viewModel.upcomingEventResult?.forEach({ item in
//            print(item.event_home_team ?? "aaaaaaaaa")
//
//          })
          print(self?.viewModel.upcomingEventResult?.count)
          print(self?.viewModel.latestEventResult?.count)

//          if self?.viewModel.upcomingEventResult != nil && self?.viewModel.latestEventResult != nil{
          if(self!.dataFetchedCounter % 2 == 0){
            self?.indicator.stopAnimating()
          }
//          }

        }
      }

      
    }


}
