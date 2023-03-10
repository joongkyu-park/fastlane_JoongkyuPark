//
//  EventDetailCoordinator.swift
//  fastlane_JoongkyuPark
//
//  Created by Apple on 2023/03/11.
//

import UIKit

final class EventDetailCoordinator: Coordinator {
    var navigationController: NavigationController
    var childCoordinators: [Coordinator] = []
    weak var parentCoordinator: HomeCoordinator?
    
    init(navigationController: NavigationController) {
        self.navigationController = navigationController
    }
    
    func start(with yeoshinEvent: YeoshinEvent) {
        let eventDetailViewController = EventDetailViewController()
        let eventDetailViewModel = EventDetailViewModel(yeoshinEvent: yeoshinEvent)
        eventDetailViewModel.coordinator = self
        eventDetailViewController.viewModel = eventDetailViewModel
        navigationController.pushViewController(eventDetailViewController, animated: true)
    }
    
}
