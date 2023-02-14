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
    
    private let apiServiceManager: VehicleListAPIServiceProtocol  // INTERFACE VEHICLE API SERVICE PROTOCOL
    private var vehicleListDisplayModal:[VechicleListPresentModal] = []
    private var selectedSortOrderEnum :SortVehicleList = SortVehicleList.vin // BY default vin type later based on user selection
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
        
        self.isLoading = true  // TO SHOW ACTIVITY INDICATOR
        
        apiServiceManager.fetchVehicleList(size: size) { [ weak self] success, vehicleListResponse, error , msg in
            self?.isLoading = false
            if success {
                self?.vehicleListDisplayModal =   VechicleListPresentModal().getVehicleListDisplayListBy(apiResponse: vehicleListResponse ?? [])
                self?.sortVehicleList() // TO SORT LIST BY VIN BY DEFAULT
                self?.reloadTableViewClosure?() // RELOAD TABLEVIEW
            }
            else{
                if error == CustomAPIError.errorMsg {
                    self?.vehicleListDisplayModal = []
                    self?.alertMessage = msg
                    self?.reloadTableViewClosure?()  // RELOAD TABLEVIEW
                }
                
            }
        }
        
    }
    
    // TO GET SORT NAME LIST
    
    func getSortNameList()->[String]{
        return [AppConstants.vehiclePageSortByVinText,AppConstants.vehiclePageSortByCarTypeText]
    }
    
    
    // SORT BY SELECTED TYPE
    
    func sortVehicleListBySegmentControl(value:Int){
        
        
        if value == SortVehicleList.vin.rawValue {
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
    
    //MARK: TABLE VIEW RELATED
    
    var numberOfCells: Int {
        return vehicleListDisplayModal.count
    }
    var numberOfSections: Int {
        return 1
    }
    func getCellViewModel( at indexPath: IndexPath ) -> VechicleListPresentModal {
        return vehicleListDisplayModal[indexPath.row]
    }
}


//PRESENT VIEW MODAL FOR VEHICLE LIST

struct VechicleListPresentModal{
    
    
    var vin:String = ""
    var makeAndModal:String = ""
    var color:String = ""
    var carType:String = ""
    var kilometrage:Int? = nil
    
    var vinKey:String = "Vin:"
    var makeAndModalKey:String = "Make and Model:"
    var colorKey:String = "Color:"
    var carTypeKey:String = "Car Type:"

    
    func getVehicleListDisplayListBy(apiResponse:[VehicleListAPIModal])->[VechicleListPresentModal] {
        var resultList:[VechicleListPresentModal] = []
        for resultItem in apiResponse {
            var rowItem = VechicleListPresentModal()
            rowItem.carType = resultItem.car_type ?? ""
            rowItem.color = resultItem.color ?? ""
            rowItem.makeAndModal = resultItem.make_and_model ?? ""
            rowItem.kilometrage = resultItem.kilometrage ?? nil
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
