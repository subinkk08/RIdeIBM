//
//  RangeCheckInputVehicleRandomList.swift
//  RidesUITests
//
//  Created by Subin Kuriakose on 13/02/23.
// TO CHECK THE INPUT RANGE IS INSIDE 1,100

import XCTest
import Rides
class RangeCheckInputVehicleRandomListTests: XCTestCase {

    
    //FAILING TEST CASES
  //  func test_validateInputRangeFailed(){
//        let inputRangeService = InputRangeValidatorRandomVehicle()
//
//        let result = inputRangeService.checkRange(input: "0")
//        XCTAssertTrue(result, "It is not valid")
   
        
//        let result2 = inputRangeService.checkRange(input: "101")
//        XCTAssertTrue(result2, "It is not valid")
//
//        let result3 = inputRangeService.checkRange(input: "adasd")
//        XCTAssertTrue(result3, "It is not valid")
  //  }
    
    //SUCCESS TEST CASES
    func test_validateInputRangeSuccess(){
        let inputRangeService = InputRangeValidatorRandomVehicle()
        
   
        let result1 = inputRangeService.checkRange(input: "79")
        XCTAssertTrue(result1, "It is valid")
      
    }
}
