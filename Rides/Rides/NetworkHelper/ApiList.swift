//
//  ApiList.swift
//  Rides

//  https://random-data-api.com/legacy_documentation
//  Created by Subin Kuriakose on 09/02/23.
//

import Foundation

struct apiList{
    
    static let baseURL = "https://random-data-api.com/api/" // BASE URL
    
    
    // TO GET RANDOM VEHICLE LIST URL -

    func getRandomVehicleListBy(size:String)->String{
        return "\(apiList.baseURL)vehicle/random_vehicle?size=\(size)"
    }
 
}

enum APIError: String, Error {
    case noNetwork = "No Network"
    case serverOverload = "Server is overloaded"
    case permissionDenied = "You don't have permission"
    case invalidURL = "Invalid parameters"
}
