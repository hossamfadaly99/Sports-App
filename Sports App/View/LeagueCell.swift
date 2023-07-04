//
//  LeagueCell.swift
//  Sports App
//
//  Created by Hossam on 01/07/2023.
//

import UIKit
import Kingfisher

class LeagueCell: UITableViewCell {

  @IBOutlet weak var leaegueName: UILabel!
  @IBOutlet weak var leagueImage: UIImageView!

  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    makeCellBorderRadius(cell: self)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

  func loadData(league: AllLeagues?){
    self.leaegueName.text = league?.league_name
    let url = URL(string: league?.league_logo ??  "")

    self.leagueImage.kf.setImage(with: url,placeholder: UIImage(named: "trophy-cup"))
  }

  override func layoutSubviews() {
          super.layoutSubviews()
    contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6))
      }

  func makeCellBorderRadius(cell: UITableViewCell){
//    cell.contentView.backgroundColor = UIColor(named: "gray_e")
    cell.contentView.backgroundColor = .white
   cell.contentView.layer.borderWidth = 0.5
   cell.contentView.layer.borderColor = UIColor.systemGray2.cgColor
   cell.contentView.layer.cornerRadius = 16
 }
}
