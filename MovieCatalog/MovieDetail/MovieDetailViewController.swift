//
//  MovieDetailViewController.swift
//  MovieCatalog
//
//  Created by Bruno Maciel on 2/24/24.
//

import Kingfisher
import UIKit

class MovieDetailViewController: UIViewController {
    
    let closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        return button
    }()
    
    let moviePosterImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        view.layer.cornerRadius = 6
        view.clipsToBounds = true
        return view
    }()
    
    let ratingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let ratingImage: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.image = UIImage(systemName: "star.fill")
        imgView.tintColor = .yellow
        return imgView
    }()
    
    let ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Rating:"
        label.textColor = .white
        label.font = .systemFont(ofSize: 17, weight: .bold)
        return label
    }()
    
    let ratingValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .red
        label.font = .systemFont(ofSize: 17, weight: .bold)
        return label
    }()
    
    var viewModel: MovieDetailViewModelProtocol
    
    init(viewModel: MovieDetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }

    @objc func tapCloseButton() {
        dismiss(animated: true)
    }

}

// MARK: Setup View
extension MovieDetailViewController {
    func setupView() {
        buildViewHierarchy()
        setupConstraints()
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        closeButton.addTarget(self, action: #selector(tapCloseButton), for: .touchUpInside)
        moviePosterImageView.kf.setImage(with: viewModel.posterUrl)
        ratingValueLabel.text = viewModel.rating
    }
    
    func buildViewHierarchy() {
        view.addSubview(closeButton)
        view.addSubview(moviePosterImageView)
        view.addSubview(ratingView)
        ratingView.addSubview(ratingImage)
        ratingView.addSubview(ratingLabel)
        ratingView.addSubview(ratingValueLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            closeButton.heightAnchor.constraint(equalToConstant: 40),
            closeButton.widthAnchor.constraint(equalToConstant: 40),
            
            moviePosterImageView.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 32),
            moviePosterImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            moviePosterImageView.heightAnchor.constraint(equalToConstant: 260),
            moviePosterImageView.widthAnchor.constraint(equalToConstant: 200),
            
            ratingView.topAnchor.constraint(equalTo: moviePosterImageView.bottomAnchor, constant: 32),
            ratingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            ratingImage.leadingAnchor.constraint(equalTo: ratingView.leadingAnchor),
            ratingImage.centerYAnchor.constraint(equalTo: ratingView.centerYAnchor),
            
            ratingLabel.leadingAnchor.constraint(equalTo: ratingImage.trailingAnchor, constant: 4),
            ratingLabel.centerYAnchor.constraint(equalTo: ratingView.centerYAnchor),
            
            ratingValueLabel.leadingAnchor.constraint(equalTo: ratingLabel.trailingAnchor, constant: 16),
            ratingValueLabel.centerYAnchor.constraint(equalTo: ratingView.centerYAnchor),
            ratingValueLabel.trailingAnchor.constraint(equalTo: ratingView.trailingAnchor)
        ])
    }
}
