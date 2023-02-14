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
    
    func checkRange(input:String)->Bool {
        guard let inputNumber = Int(input) else{
            return false
        }
        let range = (1...100) //
        if range.contains(inputNumber){
            return true
        }
        else {
            return false
        }
    }
}
