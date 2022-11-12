//
//  MarvelTests.swift
//  MarvelTests
//
//  Created by Mac on 08/11/2022.
//

import XCTest
@testable import Marvel

class MarvelTests: XCTestCase {

    func testCharacterList()  {
        let expectation = XCTestExpectation.init(description: "Get list success")
        BaseAPI.GetCharactersList(offset: 0) { status, response, erorr in
            switch status {
            case 0:
                XCTFail(" model problem \(erorr?.message ?? "")")
            case 1:
                expectation.fulfill()
            case 2:
                XCTFail(" model problem \(erorr?.message ?? "")")
            default :
                XCTFail(" internetConnection Problem")
            }
        }
    }

}
