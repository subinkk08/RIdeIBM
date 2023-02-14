//
//  EmissionCalculatorTests.swift
//  RidesTests
//
//  Created by Subin Kuriakose on 13/02/23.
//

import XCTest

class EmissionCalculatorTests: XCTestCase {

   
    //SUCCESS
    func test_EmissionCalculatorTest(){
        
        let emissionService = EmissionCalculatorService()
        let serviceModel = EmissionCalculatorModal(calculator: emissionService)
        let result = serviceModel.getEmissionCalculater(totalKilometers: 5000)
        XCTAssertEqual(result, 5000)
    }
}
