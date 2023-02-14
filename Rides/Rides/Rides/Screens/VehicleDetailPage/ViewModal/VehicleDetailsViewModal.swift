//
//  VehicleDetailsViewModal.swift
//  Rides
//
//  Created by Subin Kuriakose on 13/02/23.
//

import Foundation

class VehicleDetailsPageViewModal:NSObject {
    var reloadCollectionViewClosure: (()->())?
    var vehicleDetails:VechicleListPresentModal = VechicleListPresentModal()
    var emissionDetails:VehicleEmissionPresentModal = VehicleEmissionPresentModal()
    var totalSections = 2
    var totalPageCount = 2
    override init() {
        
    }
    
    
    // TO SET SELECTED VEHICL DETAILS FROM VEHICLE LISTING PAGE
    func setDataSource(item:VechicleListPresentModal){
        self.vehicleDetails = item
        emissionDetails = VehicleEmissionPresentModal().getEmissionPresentDetails(kilometerage: self.vehicleDetails.kilometrage ?? 0)
    }
    
    func getPageHeaderTitle()->String {
        let pageTitle = self.vehicleDetails.makeAndModal // RETURN MAKE AND MODEL AS PAGE TITLE
        return pageTitle
    }
    //MARK: COLLECTION VIEW LISTED
    
    func getCellViewModelForVehicle() -> VechicleListPresentModal {
        return vehicleDetails
    }
     func getCellViewModelForEmission() -> VehicleEmissionPresentModal {
         return emissionDetails
    }
    var numberOfSections: Int {
        return self.totalSections
    }
    func  getNumberOfItemsInSection()-> Int {
        return 1 // VEHICLE DETAILS ONLY REQUIRED 1 ITEM
    }
    
    func showVehicleDetails(){
        self.reloadCollectionViewClosure?()  // RELOAD TABLEVIEW
    }
    
    func getPageIndicatroCount() ->Int{
        return self.totalPageCount
    }
    
}

struct VehicleEmissionPresentModal {
    var emissionBasedOnKilometerageKey:String = "CO2:"
    var emissionBasedOnKilometerageVlaue:String = ""
 
    
    func getEmissionPresentDetails(kilometerage:Int) -> VehicleEmissionPresentModal {
        var emissionModal = VehicleEmissionPresentModal()
        let service = EmissionCalculatorService()
        let emissionCalculatorResult =  EmissionCalculatorModal(calculator: service).getEmissionCalculater(totalKilometers:kilometerage)
        emissionModal.emissionBasedOnKilometerageVlaue = "\(emissionCalculatorResult) emmitted"
        return emissionModal
    }
}
