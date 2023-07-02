//
//  TeamViewController.swift
//  Sports App
//
//  Created by Hossam on 02/07/2023.
//

import UIKit

class TeamViewController: UIViewController {
  @IBOutlet weak var teamImage: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var coachNameLabel: UILabel!
  @IBOutlet weak var tableView: UITableView!

  var viewModel: TeamDetailsViewModel!
  var indicator: UIActivityIndicatorView!
  var sportName = ""
  var teamId = 0
  
    override func viewDidLoad() {
        super.viewDidLoad()
      indicator = UIActivityIndicatorView(style: .large)
      indicator.center = self.view.center
      self.view.addSubview(indicator)
      indicator.startAnimating()

      let cell = UINib(nibName: "PlayerCell", bundle: nil)
      tableView.register(cell, forCellReuseIdentifier: "PlayerCell")

      viewModel = TeamDetailsViewModel()

      requestData()
      bindData()

    }

  func requestData(){
    viewModel.getTeamDetails(sportName: sportName, teamId: "\(teamId)")

  }

  func bindData(){
    viewModel.bindResultToViewController = { [weak self] in

      DispatchQueue.main.async {
        self?.teamImage.image = UIImage(named: "unknown")
        self?.teamImage.kf.setImage(with: URL(string: self?.viewModel.team?.team_logo ?? teamImagePlaceholder), placeholder: UIImage(named: "unknown"))

        self?.nameLabel.text = self?.viewModel.team?.team_name
        self?.coachNameLabel.text = self?.viewModel.team?.coaches?[0].coach_name

        self?.tableView.reloadData()
        self?.indicator.stopAnimating()

      }
    }
  }

  func makeCellBorderRadius(cell: UITableViewCell){
    cell.contentView.backgroundColor = .white
    cell.contentView.layer.borderWidth = 0.5
    cell.contentView.layer.borderColor = UIColor.systemGray2.cgColor
    cell.contentView.layer.cornerRadius = 16
  }

}

extension TeamViewController: UITableViewDelegate {

}


extension TeamViewController: UITableViewDataSource {

  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    cell.backgroundColor = .systemGray6
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    116
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    viewModel.team?.players?.count ?? 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath) as! PlayerCell
    cell.loadData(player: viewModel.team?.players?[indexPath.row])
//    cell.teamName.text = viewModel.team?.players?[indexPath.row].player_name
//
//    cell.teamImage.kf.setImage(with: URL(string: viewModel.team?.players?[indexPath.row].player_image ?? playerImagePlaceholder))

    makeCellBorderRadius(cell: cell)
    return cell
  }


}
