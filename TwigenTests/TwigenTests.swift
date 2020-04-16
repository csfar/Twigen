//
//  ProfileGeneratorTests.swift
//  TwigenTests
//
//  Created by Artur Carneiro on 16/04/20.
//  Copyright © 2020 Artur Carneiro. All rights reserved.
//

import XCTest
@testable import Twigen
import Foundation

class ProfileGeneratorTests: XCTestCase {

    private let generator = ProfileGenerator()

    func testLoadAdvice() {
        let exp = expectation(description: "Advice slip loaded")

        var profile: Profile?

        generator.generate(for: "Artur") { (result) in
            switch result {
            case .success(let profile):
                print(profile)
                exp.fulfill()
            case .failure(let error):
                print(error)
                exp.fulfill()
            }
        }

        waitForExpectations(timeout: 5) { (_) in
        }

    }

}
