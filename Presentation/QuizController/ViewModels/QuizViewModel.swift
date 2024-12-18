//
//  QuizViewModel.swift
//  CountryAppKenan
//
//  Created by Kenan on 18.12.24.
//

import Foundation

final class QuizViewModel {
    
    private (set) var searchList: CountryList?
    
    var listener: (() -> Void)?
    
    
    func getItem(index: Int) -> CountryDTO? {
        return searchList?[index]
        listener?()
    }
    
    func getItems() -> Int {
        searchList?.count ?? 0
    }
    
    
}
