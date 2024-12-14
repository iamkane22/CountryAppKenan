//
//  CountryDetailViewModel.swift
//  CountryAppKenan
//
//  Created by Kenan on 14.12.24.
//

import Foundation
final class CountryDetailViewModel {
    enum ViewState {
        case loading
        case loaded
        case success
        case error(String)
    }
    private let country: CountryDTO
    init(country: CountryDTO) {
        self.country = country
    }
    
    var listener: ((ViewState) -> Void)?
    
    func getTitle() -> String {
        country.titleString
    }
    
    func getLatlng() -> (Double, Double) {
        return (country.latlng?.first ?? 0.0, country.latlng?.last ?? 0.0)
    }
}
