//
//  FavoriteViewController.swift
//  Sports App
//
//  Created by Hossam on 31/05/2023.
//

import UIKit

class FavoriteViewController: UIViewController {
  @IBOutlet weak var tablee: UITableView!

  var viewModel: FavoriteViewModel!
  override func viewWillAppear(_ animated: Bool) {
    viewModel.getAllFavLeagues()
    self.tablee.reloadData()
  }
    override func viewDidLoad() {
        super.viewDidLoad()
      let cell = UINib(nibName: "LeagueCell", bundle: nil)
      tablee.register(cell, forCellReuseIdentifier: "LeagueCell")
      viewModel = FavoriteViewModel()

      viewModel.bindDBToViewController = { [weak self] in
        self?.tablee.reloadData()

      }

      viewModel.getAllFavLeagues()

        // Do any additional setup after loading the view.
    }
    


}

extension FavoriteViewController: UITableViewDelegate{

}
extension FavoriteViewController: UITableViewDataSource{
  func numberOfSections(in tableView: UITableView) -> Int {
    1
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    viewModel.allDBLeagues.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "LeagueCell") as! LeagueCell

    cell.leaegueName.text = viewModel.allDBLeagues[indexPath.row].leagueName

    let url = URL(string: viewModel.allDBLeagues[indexPath.row].leagueImage )
    cell.leagueImage.kf.setImage(with: url,placeholder: UIImage(named: "trophy-cup"))

    return cell
  }
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    92
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let leagueDetailsVC = self.storyboard?.instantiateViewController(identifier: "LeagueDetailsViewController") as! LeagueDetailsViewController
    leagueDetailsVC.sportName = (viewModel.allDBLeagues[indexPath.row].sportName)
    leagueDetailsVC.leagueId = (viewModel.allDBLeagues[indexPath.row].leagueId)
    leagueDetailsVC.leagueName = (viewModel.allDBLeagues[indexPath.row].leagueName)
    leagueDetailsVC.leagueImage = (viewModel.allDBLeagues[indexPath.row].leagueImage)
    leagueDetailsVC.reloadProtocol = self
    self.present(leagueDetailsVC, animated: true)
  }


}

extension FavoriteViewController: ReloadProtocol{
  func reloadTable() {
    viewModel.getAllFavLeagues()
    tablee.reloadData()
  }
}
