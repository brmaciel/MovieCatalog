//
//  HomeViewController.swift
//  MovieCatalog
//
//  Created by Bruno Maciel on 2/24/24.
//

import Combine
import UIKit

class HomeViewController: UIViewController {
    
    // MARK: UI Components
    let loadingView: UIActivityIndicatorView = {
        let loadingView = UIActivityIndicatorView()
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.transform = CGAffineTransformMakeScale(3, 3)
        return loadingView
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()

    var viewModel: HomeViewModelProtocol
    var movieSectionViewData: MoviePosterSectionViewData?
    var cancellable = Set<AnyCancellable>()
    
    init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        observeViewModelState()
        viewModel.loadMovies()
    }
    
    func showLowQualityAlert() {
        let alert = UIAlertController(title: "Low Quality Content", 
                                      message: "Unfortunately, this content does not have the expected high quality and it's no longer available.",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "close", style: .cancel))
        present(alert, animated: true)
    }
    
    func showErrorAlert() {
        let alert = UIAlertController(title: "Error",
                                      message: "Sorry, something wrong happened. We couldn't get the content. Try again later",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "try again", style: .default) { [weak self] _ in
            self?.viewModel.loadMovies()
        })
        present(alert, animated: true)
    }

}

extension HomeViewController {
    func observeViewModelState() {
        viewModel.statePublisher
            .sink { [weak self] state in
                switch state {
                case .loading(let isLoading):
                    self?.showLoading(isLoading)
                case .movies(let movies):
                    self?.showMovies(movies)
                case .error:
                    self?.showErrorAlert()
                case .contentDetails:
                    print("TODO: present content details")
                case .lowQualityContent:
                    self?.showLowQualityAlert()
                }
            }
            .store(in: &cancellable)
    }

    func showLoading(_ isLoading: Bool) {
        isLoading ? loadingView.startAnimating() : loadingView.stopAnimating()
    }
    
    func showMovies(_ viewData: MoviePosterSectionViewData) {
        tableView.isHidden = false
        movieSectionViewData = viewData
        tableView.reloadData()
    }
}

// MARK: Setup View
extension HomeViewController {
    func setupView() {
        buildViewHierarchy()
        setupConstraints()
        
        tableView.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MoviePosterSectionTableViewCell.self, forCellReuseIdentifier: MoviePosterSectionTableViewCell.identifier)
    }
    
    func buildViewHierarchy() {
        view.addSubview(loadingView)
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MoviePosterSectionTableViewCell.identifier, for: indexPath) as? MoviePosterSectionTableViewCell,
              let movieSectionViewData else {
            return UITableViewCell()
        }
        cell.delegate = self
        cell.setup(viewData: movieSectionViewData, section: indexPath.section)
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 16))
        let label = UILabel(frame: CGRect(x: 8, y: 0, width: tableView.frame.width, height: 16))
        label.text = "Section Header \(section)"
        label.font = .systemFont(ofSize: 17, weight: .bold)
        view.addSubview(label)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 16
    }
}

extension HomeViewController: MoviePosterTableViewCellDelegate {
    func didSelectPosterAt(section: Int, row: Int) {
        viewModel.selectPosterAt(section: section, row: row)
    }
}
