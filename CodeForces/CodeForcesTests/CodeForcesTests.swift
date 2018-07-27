//
//  CodeForcesTests.swift
//  CodeForcesTests
//
//  Created by student on 26/07/2018.
//  Copyright © 2018 students. All rights reserved.
//

import XCTest
import Moya
@testable import CodeForces

class CodeForcesTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testContestAPI() {
        let provider = MoyaProvider<ContestAPI>()
        provider.request(.list(gym: true)) { result in
            switch result {
            case .success(let moyaResponse):
                print(moyaResponse.statusCode)
            case .failure(let error):
                print(error)
                XCTFail()
            }
        }
    }
    
}
