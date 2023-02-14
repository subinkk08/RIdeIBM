//
//  InputRangeValidatorRandomVehicle.swift
//  Rides
//
//  Created by Subin Kuriakose on 13/02/23.
//
/*

    1. Implement validation for the input field on the Vehicle List screen

      • value must be an integer in the range 1 to 100
 */

import Foundation
class InputRangeValidatorRandomVehicle {
    
    func checkRandomRange(input: String) -> Bool {
        let startRange = 1
        let endRange = 100
        guard let inputNumber = Int(input) else{
            //checking string validation
            return false
        }
        let range = (startRange...endRange) //
        if range.contains(inputNumber){
            return true
        }
        else {
            return false
        }
    }
}
