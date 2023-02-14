//
//  VehicleListAPIService.swift
//  Rides
//
//  Created by Subin Kuriakose on 10/02/23.
//

import Foundation

// fetch vechicle list method interface
protocol VehicleListAPIServiceProtocol {
    func fetchVehicleList( size:String,complete: @escaping ( _ success: Bool, _ vehicleListResponse: [VehicleListAPIModal]?, _ error: CustomAPIError?, _ msg:String )->() )
}

// VehicleListService used to fetch random vehicle from API Implementation
class VehicleListService:VehicleListAPIServiceProtocol{
    func fetchVehicleList(size:String,complete: @escaping (Bool, [VehicleListAPIModal]?, CustomAPIError?,String) -> ()) {
        let url = URL(string:apiList().getRandomVehicleListBy(size: size))
        URLSession.shared.request(url: url, expecting: [VehicleListAPIModal].self) { result,errorMessage in
            switch result {
            case .success(let vehicleListResult):
                complete( true, vehicleListResult, nil,errorMessage )
            case .failure(_):
                complete( false, nil,CustomAPIError.errorMsg, errorMessage )
            }
        }
    }
}
