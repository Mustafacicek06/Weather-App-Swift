//
//  BaseResponse.swift
//  WeatherApp
//
//  Created by Mustafa Çiçek on 27.11.2022.
//


import Foundation

struct BaseResponse: Decodable {
    let success: Bool?
    let error: CustomError?

}

struct CustomError: Decodable {
    let code: Int?
    let type: String?
    let info: String?
}
