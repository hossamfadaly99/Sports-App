//
//  DBManager.swift
//  Sports App
//
//  Created by Hossam on 31/05/2023.
//

import Foundation
import CoreData
import UIKit

class DBManager{
    static let sharedLeagueDB = DBManager()

  var leagueName: String?
  var leagueImage: String?
  var leagueId: Int?
  var arrayOfLeagues: Array<LocalLeague>? = []
  var nsManagedLeagues : [NSManagedObject] = []
  let manager : NSManagedObjectContext!
  let entity: NSEntityDescription!

  private init(){
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    manager = appDelegate.persistentContainer.viewContext
    entity = NSEntityDescription.entity(forEntityName: "LeagueEntity", in: manager)
  }

  func insert(newLeague: LocalLeague){
    let league = NSManagedObject(entity: entity!, insertInto: manager)
    league.setValue(newLeague.leagueName, forKey: "league_name")
    league.setValue(newLeague.leagueImage, forKey: "league_image")
    league.setValue(newLeague.leagueId, forKey: "league_id")
    league.setValue(newLeague.sportName, forKey: "sport_name")

    do {
      try manager.save()
      print("saved")
    } catch let error as NSError{
      print(error)
    }
  }

  func getAllLeagues() -> Array<LocalLeague>? {
    arrayOfLeagues = []
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "LeagueEntity")

    do{
      nsManagedLeagues = try manager.fetch(fetchRequest)

      for league in nsManagedLeagues{
        var leagueObj = LocalLeague(leagueName: "", leagueImage: "", leagueId: 0, sportName: "")
        leagueObj.leagueId = league.value(forKey: "league_id") as! Int
        leagueObj.leagueName = league.value(forKey: "league_name") as! String
        leagueObj.leagueImage = league.value(forKey: "league_image") as! String
        leagueObj.sportName = league.value(forKey: "sport_name") as! String
        arrayOfLeagues?.append(leagueObj)
      }
      return  arrayOfLeagues
    } catch let error as NSError{
      print(error)
      return []
    }
  }

  func delete(id: Int) {

      manager.delete(nsManagedLeagues[id])
      do{
          try manager.save()
          print("Deleted!")
      }catch let error{
          print(error.localizedDescription)
      }
  }

}
