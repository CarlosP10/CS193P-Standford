//
//  CardButton.swift
//  Concentration
//
//  Created by Carlos Paredes on 2/6/23.
//

import UIKit

final class CardButton: UIButton {
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .orange
        self.titleLabel?.font = .systemFont(ofSize: 35)
        self.titleLabel?.textColor = .label
//        self.layer.borderColor = UIColor.black.cgColor
//        self.layer.borderWidth = 1
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpConstraint() {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 150),
            self.widthAnchor.constraint(equalToConstant: 90),
        ])
    }
    
}
