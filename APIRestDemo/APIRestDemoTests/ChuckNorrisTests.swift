//
//  ChuckNorrisTests.swift
//  APIRestDemoTests
//
//  Created by Adrian Iraizos Mendoza on 24/1/24.
//

import XCTest

@testable import APIRestDemo
final class ChuckNorrisTests: XCTestCase {
    
    var sut: ChuckNorrisModelLogic!
    var persistence: ChuckNorrisPersistence!
    var urls: URLLocator!
    override func setUpWithError() throws {
        urls = URLTesting()
        persistence = ChuckNorrisPersistence(urlProtocol: ChuckURLSessionMock.self, urls: urls)
        
        
        sut = ChuckNorrisModelLogic(persistence: persistence)
    }
    
    override func tearDownWithError() throws {
        persistence = nil
        sut = nil
    }
    
    func test_getJoke_shouldBeJoke1() throws {
        let expectation = XCTestExpectation(description: "Callback Joke")
        
        persistence.getJoke { result in
            switch result {
            case .success(let success):
                XCTAssertEqual(success.value, "Joke1")
                expectation.fulfill()
            case .failure(let failure): XCTFail(failure.localizedDescription)
                
            }
        }
       
        let result = XCTWaiter.wait(for: [expectation], timeout: 0.5)
        XCTAssertEqual(result, .completed)
        
    }

    func test_getLabels_shouldBeJoke1() throws {
        let expectation = XCTestExpectation(description: "Callback Joke")
        
        persistence.getJoke { result in
            switch result {
            case .success(let success):
                
                
                expectation.fulfill()
            case .failure(let failure): XCTFail(failure.localizedDescription)
                
            }
        }
       
        let result = XCTWaiter.wait(for: [expectation], timeout: 0.5)
        XCTAssertEqual(result, .completed)
        
    }
       
    func test_getFavorites_shouldBe5() throws {
        let favorites = try persistence.getFavorites()
        XCTAssertEqual(favorites.count, 5)
        XCTAssertEqual(favorites.first!.value, "Joke1")
    }
    
   
}
