//
//  MyResult.swift
//  Sports App
//
//  Created by Hossam on 20/05/2023.
//

import Foundation

struct MyResult<T>: Decodable where T: Decodable{
  //testing github
  var success: Int?
  var result: [T]?
  
}
