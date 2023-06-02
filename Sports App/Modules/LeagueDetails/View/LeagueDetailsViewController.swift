//
//  LeagueDetailsViewController.swift
//  Sports App
//
//  Created by Hossam on 24/05/2023.
//

import UIKit

class LeagueDetailsViewController: UIViewController {
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var favBtn: UIBarButtonItem!

  var indicator: UIActivityIndicatorView!
  var sportName:String = ""
  var leagueId:Int = 0
  var leagueName:String = ""
  var leagueImage:String = ""
  var reloadProtocol: ReloadProtocol?

  var dataFetchedCounter = 0
  let database = DBManager.sharedLeagueDB

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
    let eventCell = UINib(nibName: "EventCollectionViewCell", bundle: nil)
    collectionView.register(eventCell, forCellWithReuseIdentifier: "EventCollectionViewCell")

    let teamCell = UINib(nibName: "TeamCollectionViewCell", bundle: nil)
    collectionView.register(teamCell, forCellWithReuseIdentifier: "TeamCollectionViewCell")

    viewModel = LeagueDetailsViewModel()

    requestData()
    bindData()
    bindDB()
    checkFav()

  }

  func checkFav(){
    viewModel.isFavLeague(leagueId: leagueId)
    if (self.viewModel.isFavLeague) {
      self.favBtn.image = UIImage(systemName: "star.fill")
    }else if (self.viewModel.isFavLeague == false){
      self.favBtn.image = UIImage(systemName: "star")
    }
  }

  func bindDB(){
    viewModel.bindDBToViewController = { [weak self] in
      if ((self?.viewModel.isFavLeague == true)) {
        self?.favBtn.image = UIImage(systemName: "star.fill")
      }else if (self?.viewModel.isFavLeague == false){
        self?.favBtn.image = UIImage(systemName: "star")
      }
    }
  }

  @IBAction func backBtnClick(_ sender: Any) {
    self.dismiss(animated: true)
  }
  @IBAction func favBtnClick(_ sender: UIBarButtonItem) {
    let newLeague = LocalLeague(leagueName: leagueName, leagueImage: leagueImage, leagueId: leagueId, sportName: self.sportName)
    viewModel.isFavLeague(leagueId: leagueId)
    print(viewModel.isFavLeague)
    if self.viewModel.isFavLeague{
      viewModel.deleteFavLeague(leagueId: leagueId)
    }else {
      viewModel.insertFavLeague(league: newLeague)
    }
  }

  func requestData(){
    viewModel.getUpcomingEvent(sportName: sportName, leagueId: "\(leagueId)", startDate: Constants.currentDate, endDate: Constants.nextYear, eventType: .upcoming)

    viewModel.getUpcomingEvent(sportName: sportName, leagueId: "\(leagueId)", startDate: Constants.previousYear, endDate: Constants.currentDate, eventType: .latest)

    viewModel.getTeams(sportName: sportName, leagueId: "\(leagueId)")
  }

  func bindData(){
    viewModel.bindResultToViewController = { [weak self] in
      self?.dataFetchedCounter += 1

      DispatchQueue.main.async {

        if(self!.dataFetchedCounter % 3 == 0){
          self?.indicator.stopAnimating()
          self?.collectionView.reloadData()
          let layout = UICollectionViewCompositionalLayout{
            index, environment in
            if self?.viewModel.upcomingEventResult?.count ?? 0 == 0{
              switch index{
              case 0:
                return self?.drawTheVerticalSection()
              default:
                return self?.drawTheBottomHorizontalSection()
              }
            }else{
              switch index{
              case 0:
                return self?.drawTheHorizontalSection()
              case 1:
                return self?.drawTheVerticalSection()
              default:
                return self?.drawTheBottomHorizontalSection()
              }
            }
          }
          self?.collectionView.setCollectionViewLayout(layout, animated: true)
        }
      }
    }
  }

  func drawTheHorizontalSection() -> NSCollectionLayoutSection{
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.98), heightDimension: .absolute(185))
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 8)
    let section = NSCollectionLayoutSection(group: group)
    section.orthogonalScrollingBehavior = .continuous
    section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 0)
    section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)]
    return section
  }

  func drawTheVerticalSection() -> NSCollectionLayoutSection{
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(185))
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0)
    let section = NSCollectionLayoutSection(group: group)
    section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 8, trailing: 8)

    section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)]
    return section
  }

  func drawTheBottomHorizontalSection() -> NSCollectionLayoutSection{
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(132), heightDimension: .absolute(158))
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 8)
    let section = NSCollectionLayoutSection(group: group)
    section.orthogonalScrollingBehavior = .continuous
    section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 0)
    section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)]
    return section
  }

}

extension LeagueDetailsViewController: UICollectionViewDataSource{

  func numberOfSections(in collectionView: UICollectionView) -> Int {
    var sectionCounter = 3

    if viewModel.upcomingEventResult?.count ?? 0 == 0{
      sectionCounter -= 1
    }


    return sectionCounter
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

    if viewModel.upcomingEventResult?.count ?? 0 == 0{
      switch section{
      case 0:
        return viewModel.latestEventResult?.count ?? 0
      default:
        return viewModel.teams?.count ?? 0
      }
    } else {
      switch section{
      case 0:
        return viewModel.upcomingEventResult?.count ?? 0
      case 1:
        return viewModel.latestEventResult?.count ?? 0
      default:
        return viewModel.teams?.count ?? 0
      }
    }
  }

  func makeCellBorderRadius(cell: UICollectionViewCell){
    cell.contentView.backgroundColor = UIColor(named: "gray_e")
    cell.contentView.layer.borderWidth = 2
    cell.contentView.layer.borderColor = UIColor.black.cgColor
    cell.contentView.layer.cornerRadius = 16
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if (viewModel.upcomingEventResult?.count ?? 0 == 0 && indexPath.section == 1) || (viewModel.upcomingEventResult?.count ?? 0 != 0 && indexPath.section == 2){
      print("3a3hkbleurbcljberjhlbcjher")
      let teamVC = self.storyboard?.instantiateViewController(identifier: "TeamDetailsViewController") as! TeamDetailsViewController
      teamVC.sportName = self.sportName
      teamVC.teamId = (self.viewModel.teams?[indexPath.row].team_key)!
      self.present(teamVC, animated: true)
    }
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let eventCell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventCollectionViewCell", for: indexPath) as! EventCollectionViewCell
    let teamCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamCollectionViewCell", for: indexPath) as! TeamCollectionViewCell

    makeCellBorderRadius(cell: eventCell)
    makeCellBorderRadius(cell: teamCell)

    if viewModel.upcomingEventResult?.count ?? 0 == 0{
      switch indexPath.section {
      case 0:
        eventCell.loadData(event: (viewModel.latestEventResult?[indexPath.row])!)
        return eventCell
      default:
        teamCell.loadData(team: (viewModel.teams?[indexPath.row])!)
        return teamCell
      }
    } else {
      switch indexPath.section {
      case 0:
        eventCell.loadData(event: (viewModel.upcomingEventResult?[indexPath.row])!)
        return eventCell
      case 1:
        eventCell.loadData(event: (viewModel.latestEventResult?[indexPath.row])!)
        return eventCell
      default:
        teamCell.loadData(team: (viewModel.teams?[indexPath.row])!)
        return teamCell
      }
    }
  }

}
extension LeagueDetailsViewController: UICollectionViewDelegate{

  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

    if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "leagueDetailsHeader", for: indexPath) as? HeaderCollectionReusableView{
      if self.viewModel.upcomingEventResult?.count ?? 0 == 0{
        switch indexPath.section {
        case 0:
          sectionHeader.headerLabel.text = "Latest Events:"
        default:
          sectionHeader.headerLabel.text = "Teams:"
        }
      } else {
        switch indexPath.section {
        case 0:
          sectionHeader.headerLabel.text = "Upcoming Events:"
        case 1:
          sectionHeader.headerLabel.text = "Latest Events:"
        default:
          sectionHeader.headerLabel.text = "Teams:"
        }
      }
        return sectionHeader
      }
      return UICollectionReusableView()

  }

}

extension LeagueDetailsViewController{
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    reloadProtocol?.reloadTable()
  }
}
