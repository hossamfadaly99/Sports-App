//
//  TeamDetailsViewController.swift
//  Sports App
//
//  Created by Hossam on 30/05/2023.
//

import UIKit

class TeamDetailsViewController: UIViewController {

  @IBOutlet weak var teamImage: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var coachNameLabel: UILabel!
  @IBOutlet weak var collectionView: UICollectionView!

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

      let cell = UINib(nibName: "TeamCollectionViewCell", bundle: nil)
      collectionView.register(cell, forCellWithReuseIdentifier: "TeamCollectionViewCell")
      
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

        self?.collectionView.reloadData()
        self?.indicator.stopAnimating()

      }
    }
  }

  func makeCellBorderRadius(cell: UICollectionViewCell){
    cell.contentView.layer.borderWidth = 2
    cell.contentView.layer.borderColor = UIColor.black.cgColor
    cell.contentView.layer.cornerRadius = 16
  }


}

extension TeamDetailsViewController: UICollectionViewDelegate{

}

extension TeamDetailsViewController: UICollectionViewDataSource{
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    1
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    viewModel.team?.players?.count ?? 0
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamCollectionViewCell", for: indexPath) as! TeamCollectionViewCell

    cell.teamName.text = viewModel.team?.players?[indexPath.row].player_name

    cell.teamImage.kf.setImage(with: URL(string: viewModel.team?.players?[indexPath.row].player_image ?? playerImagePlaceholder))

    makeCellBorderRadius(cell: cell)
    return cell
  }


}

extension TeamDetailsViewController: UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      let screenWidth = UIScreen.main.bounds.width
      let screenHeight = UIScreen.main.bounds.height

      return CGSize(width: screenWidth/2 - 10, height: screenHeight/4 - 10)
  }

}
