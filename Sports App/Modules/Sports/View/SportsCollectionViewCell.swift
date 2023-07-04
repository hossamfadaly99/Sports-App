//
//  SportsCollectionViewCell.swift
//  Sports App
//
//  Created by Hossam on 21/05/2023.
//

import UIKit

class SportsCollectionViewCell: UICollectionViewCell {

  @IBOutlet weak var SportImage: UIImageView!

  @IBOutlet weak var sportLabel: UILabel!

  @IBOutlet weak var height: NSLayoutConstraint!
  @IBOutlet weak var width: NSLayoutConstraint!
  
  override class func awakeFromNib() {
    super.awakeFromNib()
  }

  override func layoutSubviews() {
    contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16))
  }




}
