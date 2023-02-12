/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation


struct VehicleListAPIModal : Codable {
	let id : Int?
	let uid : String?
	let vin : String?
	let make_and_model : String?
	let color : String?
	let transmission : String?
	let drive_type : String?
	let fuel_type : String?
	let car_type : String?
	let car_options : [String]?
	let specs : [String]?
	let doors : Int?
	let mileage : Int?
	let kilometrage : Int?
	let license_plate : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case uid = "uid"
		case vin = "vin"
		case make_and_model = "make_and_model"
		case color = "color"
		case transmission = "transmission"
		case drive_type = "drive_type"
		case fuel_type = "fuel_type"
		case car_type = "car_type"
		case car_options = "car_options"
		case specs = "specs"
		case doors = "doors"
		case mileage = "mileage"
		case kilometrage = "kilometrage"
		case license_plate = "license_plate"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		uid = try values.decodeIfPresent(String.self, forKey: .uid)
		vin = try values.decodeIfPresent(String.self, forKey: .vin)
		make_and_model = try values.decodeIfPresent(String.self, forKey: .make_and_model)
		color = try values.decodeIfPresent(String.self, forKey: .color)
		transmission = try values.decodeIfPresent(String.self, forKey: .transmission)
		drive_type = try values.decodeIfPresent(String.self, forKey: .drive_type)
		fuel_type = try values.decodeIfPresent(String.self, forKey: .fuel_type)
		car_type = try values.decodeIfPresent(String.self, forKey: .car_type)
		car_options = try values.decodeIfPresent([String].self, forKey: .car_options)
		specs = try values.decodeIfPresent([String].self, forKey: .specs)
		doors = try values.decodeIfPresent(Int.self, forKey: .doors)
		mileage = try values.decodeIfPresent(Int.self, forKey: .mileage)
		kilometrage = try values.decodeIfPresent(Int.self, forKey: .kilometrage)
		license_plate = try values.decodeIfPresent(String.self, forKey: .license_plate)
	}
}
struct ErrorMsgAPIModal : Codable {
    let error : String?

    enum CodingKeys: String, CodingKey {

        case error = "error"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        error = try values.decodeIfPresent(String.self, forKey: .error)
    }

}
