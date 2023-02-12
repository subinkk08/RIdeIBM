//
//  VehicleListViewModal.swift
//  Rides
//
//  Created by Subin Kuriakose on 10/02/23.
//

import Foundation

// This view modal is used to display vehicle list.
// assossiated with LandingPageViewController


class VehicleListViewModal:NSObject {
    
    private let apiServiceManager: VehicleListAPIServiceProtocol
    
    private var vehicleListDisplayModal:[vechicleListPresentModal] = []
    private var selectedSortOrderEnum :SortVehicleList = SortVehicleList.vin // by default vin type
    var reloadTableViewClosure: (()->())?
    var showAlertClosure: (()->())?
    var updateLoadingStatus: (()->())?
    
    init(serviceManager:VehicleListAPIServiceProtocol =  VehicleListService()) {
        self.apiServiceManager = serviceManager
    }
    
    var alertMessage: String? {
        didSet {
            //TO show Alert message
            self.showAlertClosure?()
        }
    }
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    // TO GET VEHICLE LIST FROM API
    
    func getVehicleList(size:String){
        
        self.isLoading = true
        
        guard  let sizeConverted = Int(size) else {
            self.isLoading = false
            return
        }
        
        apiServiceManager.fetchVehicleList(size: sizeConverted) { [ weak self] success, vehicleListResponse, error , msg in
            self?.isLoading = false
            if success {
                self?.vehicleListDisplayModal =   vechicleListPresentModal().getVehicleListDisplayListBy(apiResponse: vehicleListResponse ?? [])
                self?.sortVehicleList()
                self?.reloadTableViewClosure?()
            }
            else{
                if error == CustomAPIError.errorMsg {
                    self?.vehicleListDisplayModal = []
                    self?.alertMessage = msg
                    self?.reloadTableViewClosure?()
                }
                
            }
        }
        
    }
    func getSortNameList()->[String]{
        return [AppConstants.vehiclePageSortByVinText,AppConstants.vehiclePageSortByCarTypeText]
    }
    
    func sortVehicleListBySegmentControl(value:Int){
        
        
        if value == 0 {
            self.selectedSortOrderEnum = .vin
        }
        else{
            self.selectedSortOrderEnum = .carType
        }
        self.sortVehicleList()
        self.reloadTableViewClosure?()
    }
    
    func sortVehicleList() {
        switch  self.selectedSortOrderEnum {
        case .vin:
            self.vehicleListDisplayModal =  self.vehicleListDisplayModal.sorted { $0.vin < $1.vin }
            
        case .carType:
            self.vehicleListDisplayModal = self.vehicleListDisplayModal.sorted { $0.carType < $1.carType }
        }
    }
    
    //MARK: TABLE VIEW LISTED
    
    var numberOfCells: Int {
        return vehicleListDisplayModal.count
    }
    var numberOfSections: Int {
        return 1
    }
    func getCellViewModel( at indexPath: IndexPath ) -> vechicleListPresentModal {
        return vehicleListDisplayModal[indexPath.row]
    }
}

struct vechicleListPresentModal{
    
    
    var vin:String = ""
    var makeAndModal:String = ""
    var color:String = ""
    var carType:String = ""
    
    var vinKey:String = "Vin:"
    var makeAndModalKey:String = "Make and Model:"
    var colorKey:String = "Color:"
    var carTypeKey:String = " Car Type:"
    
    func getVehicleListDisplayListBy(apiResponse:[VehicleListAPIModal])->[vechicleListPresentModal] {
        var resultList:[vechicleListPresentModal] = []
        for resultItem in apiResponse {
            var rowItem = vechicleListPresentModal()
            rowItem.carType = resultItem.car_type ?? ""
            rowItem.color = resultItem.color ?? ""
            rowItem.makeAndModal = resultItem.make_and_model ?? ""
            rowItem.vin = resultItem.vin ?? ""
            resultList.append(rowItem)
        }
        return resultList
    }
    
    
}

enum SortVehicleList:Int{
    case vin = 0
    case carType
}
