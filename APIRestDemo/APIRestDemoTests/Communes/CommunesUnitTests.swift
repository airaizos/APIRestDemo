//
//  CommunesUnitTests.swift
//  APIRestDemoTests
//
//  Created by Adrian Iraizos Mendoza on 22/1/24.
//

import XCTest

@testable import APIRestDemo
final class CommunesUnitTests: XCTestCase {

    var sut: CommunesModeLogic!
    
    override func setUpWithError() throws {
        let mock = CommunesPersistenceMock()
        sut = CommunesModeLogic(persistence: mock)
       
    }

    override func tearDownWithError() throws {
       sut = nil
    }

    func testFetchRegions_shouldBe5() {
        XCTAssertEqual(sut.getRegionsCount(), 0)
        
        sut.fetchRegions()
        
        XCTAssertEqual(sut.getRegionsCount(),5)
    }
    
    func test_getRegionRow_ShouldBeRegion1Code1() {
        let region = Region(nom: "Region 1", code: "1")
        sut.fetchRegions()
        
        let indexPath = IndexPath(row: 1, section: 1)
        let row = sut.getRegionRow(indexPath: indexPath)
        
        XCTAssertEqual(row, region)
        
    }
    func test_deleteRegion() {
       
        sut.fetchRegions()
        
        let indexPath = IndexPath(row: 1, section: 1)
        sut.deleteRegion(indexPath: indexPath)
        
        XCTAssertEqual(sut.getRegionsCount(),4)
    }
    
    func test_moveRegion() {
        sut.fetchRegions()
        let from = IndexPath(row: 1, section: 1)
        let to = IndexPath(row: 4, section: 1)
        let row = sut.getRegionRow(indexPath: from)
        
        sut.moveRegion(indexPath: from, to: to)
        
        let new = sut.getRegionRow(indexPath: to)
        
        XCTAssertEqual(row, new)
        
    }

}
