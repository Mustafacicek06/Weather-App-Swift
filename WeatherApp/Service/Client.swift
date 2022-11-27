//
//  Client.swift
//  WeatherApp
//
//  Created by Mustafa Çiçek on 27.11.2022.
//

import Foundation
// 32107312f11d2020ca76c96d57f95a01 key
class Client {

    enum Endpoints {
        static let base = "https://api.weatherstack.com/current"
        
        var key = "32107312f11d2020ca76c96d57f95a01"
        
        case assets
        case markets
        case marketDetail(String)

        var stringValue: String {
            switch self {
            case .assets:
                return Endpoints.base + "/getassets"
            case .markets:
                return Endpoints.base + "/getmarkets"
            case .marketDetail(let marketId):
                return Endpoints.base + "/getmarkethistory?market=\(marketId)"
            }
        }

        var url: URL {
            return URL(string: stringValue)!
        }
    }

    @discardableResult
    class func taskForGETRequest<ResponseType: Decodable>(url: URL, hasRange: Bool = false, responseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) -> URLSessionDataTask {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                do {
                    let errorResponse = try decoder.decode(BaseResponse.self, from: data) as Error
                    DispatchQueue.main.async {
                        completion(nil, errorResponse)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            }
        }
        task.resume()

        return task
    }

    class func getWeatherSelectedCity(completion: @escaping (WeatherModel?, Error?) -> Void) {
        taskForGETRequest(url: Endpoints.assets.url, responseType: WeatherModel.self) { response, error in
            if let response = response {
                completion(response, nil)
            } else {
                completion(nil, error)
            }
        }
    }
    
}
