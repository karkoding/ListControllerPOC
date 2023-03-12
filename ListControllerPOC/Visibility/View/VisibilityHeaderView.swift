//
//  VisibilityHeaderView.swift
//  Karthik
//
//  Created by Karthik K Manoj on 12/03/23.
//

import UIKit

final class VisibilityHeaderView: UITableViewHeaderFooterView {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "VISIBILITY"
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        build()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension VisibilityHeaderView {
    func build() {
        buildViews()
        buildConstraints()
    }
    
    func buildViews() {
        contentView.addSubview(titleLabel)
    }
    
    func buildConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 22),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -14),
        ])
    }
}
