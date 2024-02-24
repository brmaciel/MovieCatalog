//
//  MoviePosterTableViewCell.swift
//  MovieCatalog
//
//  Created by Bruno Maciel on 2/24/24.
//

import UIKit

class MoviePosterTableViewCell: UITableViewCell {
    static let identifier = "MoviePosterTableViewCell"
    
    let posters: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .yellow
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension MoviePosterTableViewCell {
    private func setupView() {
        buildViewHierarchy()
        setupConstraints()
    }
    
    private func buildViewHierarchy() {
        contentView.addSubview(posters)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            posters.topAnchor.constraint(equalTo: contentView.topAnchor),
            posters.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posters.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            posters.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            posters.heightAnchor.constraint(equalToConstant: 160)
        ])
    }
}
