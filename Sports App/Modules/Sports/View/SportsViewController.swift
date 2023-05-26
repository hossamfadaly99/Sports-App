//
//  ViewController.swift
//  Sports App
//
//  Created by Hossam on 20/05/2023.
//

import UIKit

class SportsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

  @IBOutlet weak var sportsCollectionView: UICollectionView!

  let viewModel = SportsViewModel()
  let screenWidth = UIScreen.main.bounds.width
  let screenHeight = UIScreen.main.bounds.height
  

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    


  }
  override func viewDidLoad() {
    super.viewDidLoad()
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    viewModel.sportList.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SportsCollectionViewCell", for: indexPath) as! SportsCollectionViewCell

    cell.SportImage.image = UIImage(named: viewModel.sportList[indexPath.row].photo)
    cell.sportLabel.text = viewModel.sportList[indexPath.row].name


    cell.width.constant = screenWidth/2 - 24
    cell.height.constant = cell.width.constant


    return cell
  }



  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let leagueVC = self.storyboard?.instantiateViewController(withIdentifier: "LeaguesViewController") as! LeaguesViewController
    leagueVC.sportName = viewModel.sportList[indexPath.row].photo
    navigationController?.pushViewController(leagueVC, animated: true)
  }


}

