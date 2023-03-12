//
//  VisibilityCell.swift
//  Karthik
//
//  Created by Karthik K Manoj on 10/03/23.
//

import UIKit

final class VisibilityCell: UITableViewCell {
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let titleLabel = UILabel()
    
    let checkmarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        build()
    }
    
    required init?(coder: NSCoder) { nil }
    
    func configure(_ viewModel: VisibilityCellViewModel) {
        iconImageView.image = viewModel.model.iconImage
        titleLabel.text = viewModel.title
        checkmarkImageView.image = getImage(isSelected: viewModel.isSelected)
        viewModel.onSelection = { [weak self] in
            guard let self else { return }
            self.checkmarkImageView.image = self.getImage(isSelected: $0)
        }
    }
}

private extension VisibilityCell {
    func build() {
        buildViews()
        buildConstraints()
    }
    
    func buildViews() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(checkmarkImageView)
    }
    
    func buildConstraints() {
        NSLayoutConstraint.activate([
            iconImageView.heightAnchor.constraint(equalToConstant: 32),
            iconImageView.widthAnchor.constraint(equalToConstant: 32),
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            iconImageView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 12),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            titleLabel.trailingAnchor.constraint(equalTo: checkmarkImageView.leadingAnchor, constant: -12),
            checkmarkImageView.heightAnchor.constraint(equalToConstant: 18),
            checkmarkImageView.widthAnchor.constraint(equalToConstant: 18),
            checkmarkImageView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            checkmarkImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12)
        ])
      
    }
    
    func getImage(isSelected: Bool) -> UIImage? {
        isSelected ? VisibilityImage.checkmark.image : nil
    }
}
