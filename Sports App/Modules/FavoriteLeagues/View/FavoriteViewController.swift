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
    self.tablee.reloadData()
  }
    override func viewDidLoad() {
        super.viewDidLoad()
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
    let cell = tableView.dequeueReusableCell(withIdentifier: "FavLeaguesTableViewCell") as! LeaguesTableViewCell

    cell.leagueLabel.text = viewModel.allDBLeagues[indexPath.row].leagueName

    cell.leagueImage.kf.setImage(with: URL(string: viewModel.allDBLeagues[indexPath.row].leagueImage))
    

    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let leagueDetailsVC = self.storyboard?.instantiateViewController(identifier: "LeagueDetailsViewController") as! LeagueDetailsViewController
    leagueDetailsVC.sportName = (viewModel.allDBLeagues[indexPath.row].sportName)
    leagueDetailsVC.leagueId = (viewModel.allDBLeagues[indexPath.row].leagueId)
    leagueDetailsVC.leagueName = (viewModel.allDBLeagues[indexPath.row].leagueName)
    leagueDetailsVC.leagueImage = (viewModel.allDBLeagues[indexPath.row].leagueImage)
    self.present(leagueDetailsVC, animated: true)
  }


}
