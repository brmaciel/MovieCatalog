//
//  HomeCoordinator.swift
//  MovieCatalog
//
//  Created by Bruno Maciel on 2/24/24.
//

import UIKit

protocol HomeCoordinatorProtocol {
    func presentDetails(of movie: Movie)
}

class HomeCoordinator: HomeCoordinatorProtocol {
    
    weak var view: HomeViewController?
    
    func start(from presentingViewController: UIViewController) {
        let service = HomeService()
        let viewModel = HomeViewModel(coordinator: self, service: service)
        let viewController = HomeViewController(viewModel: viewModel)
        
        self.view = viewController
        viewController.modalPresentationStyle = .fullScreen
        presentingViewController.present(viewController, animated: true)
    }
    
    func presentDetails(of movie: Movie) {
        let viewController = MovieDetailViewController(viewModel: MovieDetailViewModel(movie: movie))
        viewController.modalPresentationStyle = .popover
        viewController.modalTransitionStyle = .crossDissolve
        view?.present(viewController, animated: true)
    }
}
