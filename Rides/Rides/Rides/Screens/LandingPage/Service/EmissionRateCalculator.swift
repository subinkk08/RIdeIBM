//
//  EmissionRateCalculator.swift
//  Rides
//
//  Created by Subin Kuriakose on 10/02/23.
//

import Foundation


protocol emissionCalculatorProtocol:AnyObject{
    func getEmissionCalculatoryBy(totalKilometers:Int,initialKiloMeterRange:Int)->Double
}

struct emissionCalculatorModal{
    var emissionCalculator:emissionCalculatorProtocol
    var initialKiloMeterRange:Int = 5000 // As per business rule
    var unitsOfCarbonEmittedString = "units"
    
    init(calculator:emissionCalculatorProtocol){
        self.emissionCalculator = calculator
    }
    
    func calculateEmissionRateByKilometers(kilometers:Int)->String{
        let emissionResult = self.getEmissionCalculater(totalKilometers: kilometers)
        return "\(emissionResult) \(unitsOfCarbonEmittedString)"
    }
    
    private func getEmissionCalculater(totalKilometers:Int)->Double{
        return emissionCalculator.getEmissionCalculatoryBy(totalKilometers: totalKilometers, initialKiloMeterRange: initialKiloMeterRange)

    }
}
class emissionCalculatorService:emissionCalculatorProtocol{
    
    
    //TO FIND THE EMISSION RATE BY KILOMETERS
    //for the first 5000km travelled, 1 unit of carbon is emitted per kilometre
    //after the first 5000km travelled, 1.5 units is emitted per kilometre
    
    func getEmissionCalculatoryBy(totalKilometers: Int,initialKiloMeterRange:Int) -> Double {
        
        
        let initialUnitEmissionRate:Double = 1.0
        let afterUnitEmissionRate:Double = 0.5
        var emissions:Double = 0.0

        emissions = Double(totalKilometers) * initialUnitEmissionRate

        if totalKilometers > initialKiloMeterRange{

            let reamainingKilometerEmissionUnit = (totalKilometers - initialKiloMeterRange)
           
            emissions = emissions + (Double(reamainingKilometerEmissionUnit) * afterUnitEmissionRate)
           
        }
       return  emissions
    }

    
   
}
