//
//  AllProductViewController.swift
//  Sports App
//
//  Created by Hossam on 21/05/2023.
//

import UIKit
import Kingfisher

class LeaguesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

  @IBOutlet weak var tableview: UITableView!

  var indicator: UIActivityIndicatorView!
  var sportName:String = ""

  var viewModel: LeaguesViewModel!
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.navigationBar.isHidden = true
    let cell = UINib(nibName: "LeagueCell", bundle: nil)
    tableview.register(cell, forCellReuseIdentifier: "LeagueCell")
    tableview.backgroundColor = UIColor.systemGray6
    indicator = UIActivityIndicatorView(style: .large)
    indicator.center = self.view.center
    self.view.addSubview(indicator)
    indicator.startAnimating()


    viewModel = LeaguesViewModel()
    tableview.separatorInset = UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50)

    viewModel.getItems(sportName: sportName)

    viewModel.bindResultToViewController = { [weak self] in

      DispatchQueue.main.async {

        self?.tableview.reloadData()
        self?.indicator.stopAnimating()
        
      }
    }
  }

  func numberOfSections(in tableView: UITableView) -> Int {
    1
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    self.viewModel.result?.count ?? 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "LeagueCell") as! LeagueCell

    cell.loadData(league: (self.viewModel.result?[indexPath.row]))

    return cell
  }

  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    cell.backgroundColor = .systemGray6
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    92
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let leagueDetailsVC = self.storyboard?.instantiateViewController(identifier: "LeagueDetailsViewController") as! LeagueDetailsViewController
    leagueDetailsVC.sportName = self.sportName
    leagueDetailsVC.leagueId = (viewModel.result?[indexPath.row].league_key)!
    leagueDetailsVC.leagueName = (viewModel.result?[indexPath.row].league_name)!
    leagueDetailsVC.leagueImage = viewModel.result?[indexPath.row].league_logo ?? ""
    self.present(leagueDetailsVC, animated: true)

  }

  @IBAction func backBtnClick(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
  }
}
