//
//  Coordinator.swift
//  fastlane_JoongkyuPark
//
//  Created by Apple on 2023/03/11.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: NavigationController { get set }
    var childCoordinators: [Coordinator] { get set }
}
