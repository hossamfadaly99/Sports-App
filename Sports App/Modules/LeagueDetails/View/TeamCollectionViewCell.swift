//
//  TeamCollectionViewCell.swift
//  Sports App
//
//  Created by Hossam on 30/05/2023.
//

import UIKit
import Kingfisher

class TeamCollectionViewCell: UICollectionViewCell {

  @IBOutlet weak var teamImage: UIImageView!
  @IBOutlet weak var teamName: UILabel!

  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

  func loadData(team: Team){
    teamName.text = team.team_name
    teamImage.kf.setImage(with: URL(string: team.team_logo ?? teamImagePlaceholder))
  }



}
