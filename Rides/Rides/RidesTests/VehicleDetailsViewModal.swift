//
//  EmissionCalculatorTests.swift
//  RidesTests
//
//  Created by Subin Kuriakose on 13/02/23.
//

import XCTest

class EmissionCalculatorTests: XCTestCase {

   
    private var  viewModel: EmissionCalculatorModal!
    
    override func setUp() async throws {
        let emissionService = EmissionCalculatorService()
        viewModel = EmissionCalculatorModal(calculator: emissionService)
    }
    
    //SUCCESS
    func test_EmissionCalculatorBelow5000KilometerageTest(){
        
        let successResult = viewModel.getEmissionCalculater(totalKilometers: 4521)
        XCTAssertEqual(successResult, 4521)
    }
        
    //SUCCESS
    func test_EmissionCalculatorGreaterThan5000KilometerageTest(){
        
        let successResult = viewModel.getEmissionCalculater(totalKilometers: 6789)
        XCTAssertEqual(successResult, 7683.5)
    }
    
    override func tearDown() async throws {
        viewModel = nil
    }
}
