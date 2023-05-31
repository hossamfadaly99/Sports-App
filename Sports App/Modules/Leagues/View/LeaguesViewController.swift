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
    let cell = tableView.dequeueReusableCell(withIdentifier: "LeaguesTableViewCell") as! LeaguesTableViewCell

    cell.leagueLabel.text =  self.viewModel.result?[indexPath.row].league_name ?? "aa"

    let url = URL(string: viewModel.result?[indexPath.row].league_logo ??  "https://upload.wikimedia.org/wikipedia/en/thumb/b/b1/Olympic_Rings.svg/800px-Olympic_Rings.svg.png?20111003031241")

    let processor = DownsamplingImageProcessor(size: cell.leagueImage.bounds.size)
    |> RoundCornerImageProcessor(cornerRadius: (cell.leagueImage.bounds.size.width)/2)

    cell.leagueImage.kf.setImage(
      with: url,
      placeholder: UIImage(named: "placeholderImage"),
      options: [
          .processor(processor),
          .scaleFactor(UIScreen.main.scale),
          .transition(.fade(1)),
          .cacheOriginalImage
      ])

    cell.leagueImage.layer.cornerRadius = cell.leagueImage.frame.size.width/2
    cell.leagueImage.clipsToBounds = true

    cell.contentView.layer.borderWidth = 2
    cell.contentView.layer.borderColor = UIColor.black.cgColor
    cell.contentView.layer.cornerRadius = cell.leagueImage.frame.size.width/2


    return cell
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
