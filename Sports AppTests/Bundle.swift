//
//  Bundle.swift
//  Sports AppTests
//
//  Created by Hossam on 31/05/2023.
//

import Foundation

extension Bundle {
    public class var unitTest: Bundle {
        return Bundle(for: NetworkingTest.self)
    }
}
