//
//  DefaultCoordinator.swift
//  fastlane_JoongkyuPark
//
//  Created by Apple on 2023/03/11.
//

import UIKit

final class HomeCoordinator: Coordinator {
    var navigationController: NavigationController
    var childCoordinators: [Coordinator] = []
    
    init(navigationController: NavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let homeViewController = HomeViewController()
        let homeViewModel = HomeViewModel(
            yeoshinUseCase: YeoshinUseCase(
                yeoshinRepository: DefaultYeoshinRepository(
                    networkAPI: NetworkAPI())))
        homeViewModel.coordinator = self
        homeViewController.viewModel = homeViewModel
        navigationController.pushViewController(homeViewController, animated: true)
    }
    
    func pushEventDetailViewController(with yeoshinEvent: YeoshinEvent) {
        let eventDetailCoordinator = EventDetailCoordinator(navigationController: navigationController)
        eventDetailCoordinator.parentCoordinator = self
        childCoordinators.append(eventDetailCoordinator)
        eventDetailCoordinator.start(with: yeoshinEvent)
    }
    
}
