//
//  Constants.swift
//  Sports App
//
//  Created by Hossam on 21/05/2023.
//

import Foundation
class Constants{
  static let API_KEY = "8274578408f4c99f3f02039c0c89bbbf877d62b7a2479be30a1fef4bcbce1265"

  static var currentDate: String {
    return getFormattedDateAddedBy(year: 0)
  }

  static var nextYear: String {
    return getFormattedDateAddedBy(year: 3)
  }

  static var previousYear: String {
    return getFormattedDateAddedBy(year: -3)
  }

  private static func getFormattedDateAddedBy(year: Int) -> String{
    let currentDate = Date()
    var dateComponent = DateComponents()

    dateComponent.month = year

    let futureDate = Calendar.current.date(byAdding: dateComponent, to: currentDate)

    let dateFormatter = DateFormatter()

    dateFormatter.dateFormat = "yyyy-MM-dd"

    let result = dateFormatter.string(from: futureDate!)

    return result
  }


}
let teamImagePlaceholder = "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/EA_Sports_monochrome_logo.svg/2048px-EA_Sports_monochrome_logo.svg.png"

let playerImagePlaceholder = "https://img.uxwing.com/wp-content/themes/uxwing/download/peoples-avatars-thoughts/person-profile-icon.png"
