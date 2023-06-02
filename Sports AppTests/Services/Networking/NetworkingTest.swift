//
//  NetworkingTest.swift
//  Sports AppTests
//
//  Created by Hossam on 31/05/2023.
//

import XCTest
@testable import Sports_App

final class NetworkingTest: XCTestCase {
  var sut: NetworkService!

      override func setUp() {
          super.setUp()
          sut = NetworkManager()
      }

      override func tearDown() {
          sut = nil
          super.tearDown()
      }

      func test_fetch_teams() {
          // Given
          let promise = XCTestExpectation(description: "Fetch teams completed")
          var responseTeams: [Team]?

          // When
          guard let bundle = Bundle.unitTest.path(forResource: "apiResponse", ofType: "json") else {
              XCTFail("Error: content not found")
              return
          }
        sut.fetchData(url: "\(URL(fileURLWithPath: bundle))", param: [:]){ (teams: MyResult<Team>?) in
          responseTeams = teams?.result
              promise.fulfill()
          }
          wait(for: [promise], timeout: 10)

          // Then
          XCTAssertNotNil(responseTeams)
      }

  func test_fetch_nil_teams() {
      // Given
      let promise = XCTestExpectation(description: "Fetch teams completed")
      var responseTeams: [Team]?

      // When
      guard let bundle = Bundle.unitTest.path(forResource: "apiResponse", ofType: "json") else {
          XCTFail("Error: content not found")
          return
      }
    sut.fetchData(url: "invalid url!", param: [:]){ (teams: MyResult<Team>?) in
      responseTeams = teams?.result
          promise.fulfill()
      }
      wait(for: [promise], timeout: 10)

      // Then
      XCTAssertNil(responseTeams)
  }


}
