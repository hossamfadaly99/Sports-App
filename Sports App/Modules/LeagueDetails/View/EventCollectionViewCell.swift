//
//  EventCollectionViewCell.swift
//  Sports App
//
//  Created by Hossam on 30/05/2023.
//

import UIKit
import Kingfisher

class EventCollectionViewCell: UICollectionViewCell {

  @IBOutlet weak var teamOneImage: UIImageView!
  @IBOutlet weak var teamTwoImage: UIImageView!
  @IBOutlet weak var teamOneLabel: UILabel!
  @IBOutlet weak var teamTwoLabel: UILabel!
  @IBOutlet weak var resultLabel: UILabel!

  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
  func loadData(event: Event?){
    print("fwkrjtkjrbhthj")
    print(event?.leagueRound)
    print(event?.eventStadium)
    print(event?.leagueLogo)
//    print(event.c)
    teamOneLabel.text = event?.eventHomeTeam
    teamTwoLabel.text = event?.eventAwayTeam
    teamOneImage.kf.setImage(with: URL(string: event?.homeTeamLogo ?? teamImagePlaceholder))
    teamTwoImage.kf.setImage(with: URL(string: event?.awayTeamLogo ?? teamImagePlaceholder))
    resultLabel.text = event?.finalResult ?? ""
    
  }


}
