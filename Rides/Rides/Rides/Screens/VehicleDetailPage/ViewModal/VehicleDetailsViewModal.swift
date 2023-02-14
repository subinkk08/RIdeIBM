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
    var totalSections = 1
    override init() {
        
    }
    
    
    // TO SET SELECTED VEHICL DETAILS FROM VEHICLE LISTING PAGE
    func setDataSource(item:VechicleListPresentModal){
        self.vehicleDetails = item
    }
    
    func getPageHeader()->String {
        let pageTitle = self.vehicleDetails.makeAndModal // RETURN MAKE AND MODEL AS PAGE TITLE
        return pageTitle
    }
    //MARK: COLLECTION VIEW LISTED
    
    func getCellViewModel( section:Int ,indexPath: IndexPath ) -> VechicleListPresentModal {
        return vehicleDetails
    }
    var numberOfSections: Int {
        return self.totalSections
    }
    func  getNumberOfItemsInSection(section:Int)-> Int {
        return 1 // VEHICLE DETAILS ONLY REQUIRED 1 ITEM
    }
    
    func showVehicleDetails(){
        self.reloadCollectionViewClosure?()  // RELOAD TABLEVIEW
    }
    
}
