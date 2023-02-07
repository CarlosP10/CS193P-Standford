//
//  CView.swift
//  Concentration
//
//  Created by Carlos Paredes on 2/4/23.
//

import UIKit

class CView: UIView {
    
    //MARK: - UI
    private let button1: CardButton = CardButton()
    private let button2: CardButton = CardButton()
    private let button3: CardButton = CardButton()
    private let button4: CardButton = CardButton()
        
    private let flipCountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 50)
        label.textColor = .label
        label.textAlignment = .center
        label.text = "Flips: 0"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stackViewLeft: UIStackView = {
        let view = UIStackView()
        view.distribution = .fillProportionally
        view.axis = .vertical
        view.spacing = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let stackViewRight: UIStackView = {
        let view = UIStackView()
        view.distribution = .fillProportionally
        view.spacing = 10
        view.axis = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - Constants
    var flipCount: Int = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    private var cardButtons: [UIButton] = []
    
    private var emojiChoices = ["👻", "🎃", "🍏", "🫐", "🍕"]
    
    var emoji = [Int: String]()
    
    lazy var game: Concentration = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        setUpConstraints()
        button1.addTarget(self, action: #selector(touchCard), for: .touchUpInside)
        button2.addTarget(self, action: #selector(touchCard), for: .touchUpInside)
        button3.addTarget(self, action: #selector(touchCard), for: .touchUpInside)
        button4.addTarget(self, action: #selector(touchCard), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView() {
        backgroundColor = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(stackViewLeft, stackViewRight, flipCountLabel)
        stackViewLeft.addArrangedSubviews(button1, button3)
        stackViewRight.addArrangedSubviews(button2, button4)
        cardButtons = [button1, button2, button3, button4]
    }
    
    @objc
    private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Choose card was not in cardButtons")
        }
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? .clear : .orange
            }
        }
    }
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            ///arc4random_uniform: generates random from 0 to value
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
    
    private func setUpConstraints() {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 40)/4
        NSLayoutConstraint.activate([
            stackViewLeft.topAnchor.constraint(equalTo: topAnchor, constant: width),
            stackViewLeft.leadingAnchor.constraint(equalTo: leadingAnchor, constant: width),
            stackViewLeft.widthAnchor.constraint(equalToConstant: 90),
            stackViewLeft.heightAnchor.constraint(equalToConstant: 310),
            
            stackViewRight.topAnchor.constraint(equalTo: topAnchor, constant: width+15),
            stackViewRight.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -width),
            stackViewRight.widthAnchor.constraint(equalToConstant: 90),
            stackViewRight.heightAnchor.constraint(equalToConstant: 310),
            
            flipCountLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            flipCountLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            flipCountLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 15),
        ])
    }

}
