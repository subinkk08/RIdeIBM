//
//  ErrorAPIModel.swift
//  Rides
//
//  Created by Subin Kuriakose on 12/02/23.
//

import Foundation
struct ErrorAPIResponseModel : Codable {
    let error : String?

    enum CodingKeys: String, CodingKey {

        case error = "error"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        error = try values.decodeIfPresent(String.self, forKey: .error)
    }

}
