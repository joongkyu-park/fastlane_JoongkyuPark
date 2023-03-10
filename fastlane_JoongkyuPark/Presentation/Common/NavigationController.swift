//
//  NavigationController.swift
//  fastlane_JoongkyuPark
//
//  Created by Apple on 2023/03/11.
//

import UIKit

final class NavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationController()
    }
}

extension NavigationController {
    private func setUpNavigationController() {
        setStyleOfNavigationController()
    }
    private func setStyleOfNavigationController() {
        navigationBar.backgroundColor = .white
        navigationBar.shadowImage = UIImage()
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .medium)]
    }
}
