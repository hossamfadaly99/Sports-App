//
//  PlayerCell.swift
//  Sports App
//
//  Created by Hossam on 02/07/2023.
//

import UIKit
import Kingfisher

class PlayerCell: UITableViewCell {

  @IBOutlet weak var playerNumber: UILabel!
  @IBOutlet weak var playerName: UILabel!
  @IBOutlet weak var playerImage: UIImageView!
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


  func loadData(player: Player?){
    self.playerName.text = player?.player_name
    self.playerNumber.text = "#\(player?.player_number ?? "")"
    self.playerImage.kf.setImage(with: URL(string: player?.player_image ?? ""), placeholder: UIImage(named: "soccer-player"))
  }
  override func layoutSubviews() {
          super.layoutSubviews()
    contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4))
      }
    
}
