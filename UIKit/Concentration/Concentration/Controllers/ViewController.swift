//
//  ViewController.swift
//  Concentration
//
//  Created by Carlos Paredes on 2/4/23.
//

import UIKit

final class ViewController: UIViewController {
    
    private let concentrationView = CView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(concentrationView)
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            concentrationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            concentrationView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            concentrationView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            concentrationView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    


}

