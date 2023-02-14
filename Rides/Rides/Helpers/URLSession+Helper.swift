//
//  URLSession+Helper.swift
//  Rides
//
//  Created by Subin Kuriakose on 09/02/23.
//

import Foundation
enum CustomAPIError:Error {
    case invalidUrl
    case invalidData
    case errorMsg
    case noInternet
}
extension URLSession{
    
    func request<T:Codable>(url:URL?,expecting:T.Type,completion: @escaping (Result<T,Error>,String)-> Void){
        guard let url = url else{
            completion(.failure(CustomAPIError.invalidUrl),CommonNetWorkResponseErrorMsg.invalidInput)
            return
        }
        let task = self.dataTask(with: url) { data,_, error in
            guard let data = data else{
                if let error = error {
                
                    completion(.failure(error),error.localizedDescription)
                }
                else{
                    completion(.failure(CustomAPIError.invalidData),CommonNetWorkResponseErrorMsg.somethingWentWrong)
                }
                return
            }
            do{
                //CHECK ERROR RESPONCE
                if let errorResult = try? JSONDecoder().decode(ErrorAPIResponseModel.self, from: data) {
                    let errorMsg = errorResult.error ?? ""
                    completion(.failure(CustomAPIError.errorMsg),errorMsg)
                }
                else{
                    let result = try JSONDecoder().decode(expecting, from: data)
                    completion(.success(result),"")
                }
               
                
            }
            catch{
                completion(.failure(error),CommonNetWorkResponseErrorMsg.somethingWentWrong)
            }
        }
        task.resume()
    }
}

