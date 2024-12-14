//
//  CoreErrorModel.swift
//  CountryAppKenan
//
//  Created by Kenan on 14.12.24.
//
import Foundation
struct CoreErrorModel: Error, Decodable {
    let code: Int?
    let message: String?
    
    
    static func authError(code: Int) -> CoreErrorModel {
        return CoreErrorModel(code: code, message: "try again later")
    }
    
    static func generalError() -> CoreErrorModel {
        return CoreErrorModel(code: 500, message: "error")
    }

    static func decodingError() -> CoreErrorModel {
        return CoreErrorModel(code: 0, message: "Can not parse json")
    }
}

