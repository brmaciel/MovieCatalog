//
//  EmptySectionTableViewCell.swift
//  MovieCatalog
//
//  Created by Bruno Maciel on 2/24/24.
//

import UIKit

class EmptySectionTableViewCell: UITableViewCell {
    static let identifier = "EmptySectionTableViewCell"
    
    private var section: Int = 0
    var tryAgainAction: ((Int) -> Void)?
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .center
        return stackView
    }()
    
    let errorLabel: UILabel = {
        let label = UILabel()
        label.text = "Error loading your movies"
        return label
    }()
    
    let tryAgainButton: UIButton = {
        let button = UIButton()
        button.setTitle("Try again", for: .normal)
        button.setImage(UIImage(systemName: "exclamationmark.triangle"), for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.tintColor = .red
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(section: Int, tryAgainAction: @escaping (Int) -> Void) {
        self.section = section
        self.tryAgainAction = tryAgainAction
    }
    
    @objc func tapTryAgainButton() {
        tryAgainAction?(section)
    }
}

extension EmptySectionTableViewCell {
    private func setupView() {
        buildViewHierarchy()
        setupConstraints()
        
        tryAgainButton.addTarget(self, action: #selector(tapTryAgainButton), for: .touchUpInside)
    }
    
    private func buildViewHierarchy() {
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(errorLabel)
        stackView.addArrangedSubview(tryAgainButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
        ])
    }
}
