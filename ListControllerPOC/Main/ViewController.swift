//
//  ViewController.swift
//  ListControllerPOC
//
//  Created by Karthik K Manoj on 12/03/23.
//

import UIKit

final class ViewController: UIViewController {
    lazy var visibilityBtn: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleDidTap), for: .touchUpInside)
        button.setTitle("Visibility", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        build()
    }
    
    @objc func handleDidTap() {
      let listViewContorller = ListViewController()
        listViewContorller.modalPresentationStyle = .pageSheet
        if let sheet = listViewContorller.sheetPresentationController { sheet.detents = [.medium()] }
        self.present(listViewContorller, animated: true)
    }
}

private extension ViewController {
    func build() {
        buildViews()
        buildConstraints()
    }
    
    func buildViews() {
        view.addSubview(visibilityBtn)
    }
    
    func buildConstraints() {
        visibilityBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        visibilityBtn.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
