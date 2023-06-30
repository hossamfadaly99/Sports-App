//
//  Utilities.swift
//  Sports App
//
//  Created by Hossam on 30/06/2023.
//

import Foundation

func reformatDate(dateString: String) -> String{

  let dateFormatter = DateFormatter()
  dateFormatter.dateFormat = "yyyy-MM-dd"
  let date = dateFormatter.date(from: dateString)!

  let calendar = Calendar.current
  let monthSymbol = calendar.monthSymbols[calendar.component(.month, from: date) - 1]
  let day = calendar.component(.day, from: date)

  var daySuffix = "th"
  switch day % 10 {
  case 1:
      daySuffix = "st"
  case 2:
      daySuffix = "nd"
  case 3:
      daySuffix = "rd"
  default:
      break
  }

  let formattedDate = "\(monthSymbol) \(day)\(daySuffix)"
  
  return formattedDate
}
