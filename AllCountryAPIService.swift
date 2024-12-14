//
//  AllCountryAPIService.swift
//  CountryAppKenan
//
//  Created by Kenan on 14.12.24.
//

import Foundation
final class AllCountryAPIService {
    static let instance =  AllCountryAPIService()
    private init() {}
    
    func getCountry(completion: @escaping((CountryList?, CoreErrorModel?) -> Void?)) {
        CoreAPIManager.instance.request(
            type: CountryList.self,
            url: AllCountryHelper.all.path,
            method: .GET) { [weak self] result in
                guard let _ = self else {return}
                switch result {
                    case .success(let data):
                        completion(data, nil)
                    case .failure(let error):
                        completion(nil, error)
                }
            }
    }
    
}
