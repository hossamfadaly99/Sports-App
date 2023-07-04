//
//  EventCollectionViewCell.swift
//  Sports App
//
//  Created by Hossam on 30/05/2023.
//

import UIKit
import Kingfisher

class EventCollectionViewCell: UICollectionViewCell {

  @IBOutlet weak var stadiumLabel: UILabel!
  @IBOutlet weak var roundLabel: UILabel!
  @IBOutlet weak var teamOneImage: UIImageView!
  @IBOutlet weak var teamTwoImage: UIImageView!
  @IBOutlet weak var teamOneLabel: UILabel!
  @IBOutlet weak var teamTwoLabel: UILabel!
  @IBOutlet weak var resultLabel: UILabel!
  @IBOutlet weak var upcomingDate: UIView!
  @IBOutlet weak var upcomingDateText: UILabel!

  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    upcomingDate.layer.borderColor = UIColor(named: "main_green")?.cgColor
    upcomingDate.layer.cornerRadius = 12
    upcomingDate.layer.borderWidth = 1
    upcomingDate.layer.backgroundColor = UIColor(named: "main_green_very_light")?.cgColor
    }
  func loadData(event: Event?){
    upcomingDateText.text = reformatDate(dateString: event?.eventDay ?? "")
    stadiumLabel.text = "\(event?.eventStadium?.split(separator: "(").first ?? "")"
    roundLabel.text = event?.leagueRound
    teamOneLabel.text = event?.eventHomeTeam
    teamTwoLabel.text = event?.eventAwayTeam

    
    if event?.finalResult ?? "" == "-"{
      upcomingDate.isHidden = false
      resultLabel.isHidden = true
    } else {
      upcomingDate.isHidden = true
      resultLabel.isHidden = false
    }

    teamOneImage.kf.setImage(with: URL(string: event?.homeTeamLogo ?? teamImagePlaceholder))
    teamTwoImage.kf.setImage(with: URL(string: event?.awayTeamLogo ?? teamImagePlaceholder))
    resultLabel.text = event?.finalResult ?? ""
    
  }


}
