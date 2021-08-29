//
//  MainTabBarController.swift
//  Musicians
//
//  Created by Артём on 25.08.2021.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
        setupViewControllers()
    }
    
    private func configureAppearance() {
        view.backgroundColor = .systemBackground
    }
    
    private func setupViewControllers() {
        viewControllers = [
//            createNavController(for: FeedViewController(),
//                                title: "Feed",
//                                image: UIImage(named: "LibraryIcon")!),
            createNavController(for: SearchViewController(),
                                title: "Artists",
                                image: UIImage(named: "DjIcon")!)
        ]
    }
    
    private func createNavController(for rootViewController: UIViewController,
                                     title: String,
                                     image: UIImage) -> UINavigationController {
        
        let navViewController = UINavigationController(rootViewController: rootViewController)
        navigationController?.setNavigationBarHidden(true, animated: false)
        navViewController.tabBarItem.title = title
        navViewController.tabBarItem.image = image
        navViewController.navigationBar.prefersLargeTitles = true
        rootViewController.navigationItem.title = title
        return navViewController
    }
}
