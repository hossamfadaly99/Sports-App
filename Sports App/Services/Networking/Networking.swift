//
//  Networking.swift
//  Sports App
//
//  Created by Hossam on 20/05/2023.
//

import Foundation
import Alamofire

protocol NetworkService{
  static func fetchData<T: Decodable>(url: String, param: Parameters, compilitionHandler: @escaping (MyResult<T>?) -> Void)
}

class NetworkManager: NetworkService{
  static func fetchData<T>(url: String, param: Parameters, compilitionHandler: @escaping (MyResult<T>?) -> Void) where T : Decodable {
//    var myUrl = "https://apiv2.allsportsapi.com/football/"


    AF.request(url, method: .get, parameters: param).responseJSON { response in

      switch response.result{
      case .success(_):
        do{

          guard let jsonResponse = try? response.result.get() else {return}
          guard let jsonData = try? JSONSerialization.data(withJSONObject: jsonResponse) else {return}
           let responseObj = try JSONDecoder().decode(MyResult<T>.self, from: jsonData)
          
          compilitionHandler(responseObj)

        }catch let error{
            print(error)
        }
      case .failure(let error):
        print(error.localizedDescription)
        compilitionHandler(nil)
      }
    }
  }


}
