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
    
    makeCollectionInCenter()

  }
  override func viewDidLoad() {
    super.viewDidLoad()
    makeCollectionInCenter()
  }

  func makeCellBorderRadius(cell: UICollectionViewCell){
    cell.contentView.layer.borderWidth = 0.5
    cell.contentView.layer.borderColor = UIColor.systemGray2.cgColor
    cell.contentView.layer.cornerRadius = 12
  }

  func makeCollectionInCenter(){
    // Calculate the height of the collection view cell
    let cellHeight = screenWidth/2 - 24

    // Calculate the height of the content that will be displayed in the collection view
    let contentHeight = cellHeight * 2.0

    // Calculate the vertical offset needed to center the content vertically
    let verticalOffset = (sportsCollectionView.frame.size.height - contentHeight) / 2.0
    

    // Set the content inset of the collection view
    sportsCollectionView.contentInset = UIEdgeInsets(top: verticalOffset - 22, left: 0, bottom: verticalOffset + 22, right: 0)
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

    makeCellBorderRadius(cell: cell)
    return cell
  }



  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let leagueVC = self.storyboard?.instantiateViewController(withIdentifier: "LeaguesViewController") as! LeaguesViewController
    leagueVC.sportName = viewModel.sportList[indexPath.row].photo
    navigationController?.pushViewController(leagueVC, animated: true)
  }


}

