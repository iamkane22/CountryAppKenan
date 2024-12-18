//
//  ProfileController.swift
//  CountryAppKenan
//
//  Created by Kenan on 18.12.24.
//

import UIKit

final class ProfileController: BaseViewController {
    
    private let viewModel: ProfileViewModel
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
