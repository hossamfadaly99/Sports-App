//
//  LeaguesTableViewCell.swift
//  Sports App
//
//  Created by Hossam on 22/05/2023.
//

import UIKit
import Kingfisher

class LeaguesTableViewCell: UITableViewCell {

  @IBOutlet weak var leagueImage: UIImageView!

  @IBOutlet weak var leagueLabel: UILabel!

  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

  override func layoutSubviews() {
          super.layoutSubviews()
    contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4))
      }


}
