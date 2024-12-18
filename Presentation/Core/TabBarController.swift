//
//  TabBarController.swift
//  CountryAppKenan
//
//  Created by Kenan on 18.12.24.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupControllers()
    }
    
    fileprivate func setupControllers() {
        
        let mainController = MainViewController(viewModel: MainViewModel())
        let quizController = QuizController(viewModel: QuizViewModel())
        let profileController = ProfileController(viewModel: ProfileViewModel())
        
        let nav1 = UINavigationController(rootViewController: mainController)
        let nav2 = UINavigationController(rootViewController: quizController)
        let nav3 = UINavigationController(rootViewController: profileController)
        
        nav1.tabBarItem = UITabBarItem(title: "Countries", image: UIImage(systemName: "map.circle"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Quiz", image: UIImage(systemName: "questionmark.bubble"), tag: 2)
        nav3.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.circle"), tag: 3)
        
        setViewControllers([nav1, nav2, nav3], animated: true)
        
    }
}
