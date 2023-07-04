//
//  AlertCreator.swift
//  Shopify User
//
//  Created by MAC on 14/06/2023.
//

import Foundation
import UIKit
class AlertCreator{
    static func showAlert(title: String?, message: String?, viewController: UIViewController) {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            viewController.present(alertController, animated: true, completion: nil)
        }

  static func showAlertWithAction(title: String?, message: String?, viewController: UIViewController, compilitionHandler: @escaping () -> Void) {
          let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "Remove", style: .default) {_ in
      compilitionHandler()
    }
    let noAction = UIAlertAction(title: "Cancel", style: .cancel ,handler: nil)
          alertController.addAction(okAction)
          alertController.addAction(noAction)
          viewController.present(alertController, animated: true, completion: nil)
      }

}
