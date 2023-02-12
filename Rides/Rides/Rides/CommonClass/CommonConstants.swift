//
//  CommonConstants.swift
//  Rides
//
//  Created by Subin Kuriakose on 11/02/23.
//

import Foundation
import UIKit



//MARK: FONT CUSTOM COMMON CLASS
struct CommonFontList{
    static let tableViewKeyLabelFont = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
    static let tableViewValueLabelFont = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
    static let pageHeaderTitleLabelFont = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
}
struct AppConstants{
    static let AppName = "Rides"
    static let pageTitle = "Vehicle List"
    static let vehiclePageSortByVinText = "Vin"
    static let vehiclePageSortByCarTypeText = "Car Type"
    static let vehicleListTableViewAnimateDuration:Double = 0.2
    static let AlertOk = "Ok"
}
struct CommonNetWorkResponseErrorMsg {
   static let somethingWentWrong = "Something went wrong."
   static let noNetWorkFound = "No network found."
    static let invalidUrl = "Invalid URL"
    static let invalidData = "Invalid Data"
    static let success = "Success"
}
