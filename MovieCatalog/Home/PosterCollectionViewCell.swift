//
//  PosterCollectionViewCell.swift
//  MovieCatalog
//
//  Created by Bruno Maciel on 2/24/24.
//

import Kingfisher
import UIKit

class PosterCollectionViewCell: UICollectionViewCell {
    static let identifier = "PosterCollectionViewCell"
    
    let posterImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        view.layer.cornerRadius = 6
        view.layer.borderWidth = 1
        view.clipsToBounds = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(viewData: MoviePosterViewData) {
        posterImageView.layer.borderColor = viewData.isHightQuality ? UIColor.red.cgColor : UIColor.clear.cgColor
        posterImageView.kf.setImage(with: viewData.movieUrl)
    }
}

extension PosterCollectionViewCell {
    private func setupView() {
        buildViewHierarchy()
        setupConstraints()
    }
    
    private func buildViewHierarchy() {
        contentView.addSubview(posterImageView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
