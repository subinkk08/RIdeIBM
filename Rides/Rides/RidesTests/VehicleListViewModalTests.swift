//
//  VehicleListViewModal.swift
//  RidesUITests
//
//  Created by Subin Kuriakose on 13/02/23.
// TO CHECK THE INPUT RANGE IS INSIDE 1,100

import XCTest
import Rides
class RangeCheckInputVehicleRandomListTests: XCTestCase {

 
    private var  viewModel: InputRangeValidatorRandomVehicle!
    
    override func setUp() async throws {
        viewModel = InputRangeValidatorRandomVehicle()
    }
    
    //SUCCESS TEST CASES
    // value must be an integer in the range 1 to 100
    func testChecktRangeSuccess(){
        let successResult = viewModel.checkRandomRange(input: "79")
        XCTAssertTrue(successResult, "It is valid")
      
    }
    
    //SUCCESS TEST CASES
    func testChecktRangeFailure(){
        let successResult = viewModel.checkRandomRange(input: "102")
        XCTAssertFalse(successResult, "It is not valid")
      
    }
    
    override func tearDown() async throws {
        viewModel = nil
    }
}
