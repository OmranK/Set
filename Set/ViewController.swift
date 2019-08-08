//
//  ViewController.swift
//  Set
//
//  Created by Omran Khoja on 8/6/19.
//  Copyright © 2019 AcronDesign. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game = Game()
    private var selectedButtons = [UIButton]()
    @IBOutlet var setCardButtons: [UIButton]!
    private var activeCardButtons = 11
    @IBOutlet weak var alertLabel: UILabel!
    
    @IBAction func dealThreeButton(_ sender: UIButton) {
        game.draw()
        addGameCards()
    }
    
    @IBAction func cardButtonPressed(_ sender: UIButton) {
        if let cardIndex = setCardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardIndex)
            chooseButton(at: sender)
            updateView()
        }
    }
    
    private func chooseButton(at card: UIButton) {
        
        alertLabel.text = nil
        
        func resetCards() {
            setCardButtons.forEach() { $0.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) }
            selectedButtons.removeAll()
        }
        
        func deselectCard() {
            card.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            card.layer.borderWidth = 3.0
            selectedButtons.remove(at: selectedButtons.firstIndex(of: card)!)
        }
        
        func selectCard(){
            card.layer.borderColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
            card.layer.borderWidth = 3.0
        }
        
        if selectedButtons.count < 3 {
            
            if selectedButtons.contains(card) {
                deselectCard()
                return
            } else {
                selectedButtons.append(card)
                selectCard()
                if game.selectedCardsAreASet {
                    resetCards()
                    alertLabel.text = "That's a set! =)"
                    return
                }
            }
        }
        
        if selectedButtons.count == 3 {
            alertLabel.text = "Not a set! =("
            resetCards()
            // updateScore()
        }
        
    }
    
    
    //MARK: UI Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateView()
    }
    
    //    private func setUpGame() {
    //    }
    
    private func addGameCards(){
        if activeCardButtons < 23 {
            activeCardButtons += 3
            updateView()
        }
    }
    
    private func updateView() {
        for index in 0...activeCardButtons{
            let button = setCardButtons[index]
            button.isHidden = false
            let card = game.cardsOnTheTable[index]
            button.setAttributedTitle(setCardTitle(with: card), for: .normal)
        }
        
    }
    
    private func setCardTitle(with card: Card) -> NSAttributedString {
        var cardTitle = String()
        if let shape = ModelToView.shapes[card.cardShape] {
            cardTitle = shape
            switch card.cardNumber {
            case .two: cardTitle.append(" \(shape)")
            case .three: cardTitle.append(" \(shape) \(shape)")
            default:
                break
            }
        }
        let attributes: [NSAttributedString.Key : Any] = [
            .strokeColor: ModelToView.colors[card.cardColor]!,
            .strokeWidth: ModelToView.strokeWidth[card.cardFill]!,
            .foregroundColor: ModelToView.colors[card.cardColor]!.withAlphaComponent(ModelToView.alpha[card.cardFill]!),
        ]
        return NSAttributedString(string: cardTitle, attributes: attributes)
    }
}

struct ModelToView {
    static let shapes: [Card.CardShape: String] = [.circle: "●", .triangle: "▲", .square: "■"]
    static var colors: [Card.CardColor: UIColor] = [.red: #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1), .purple: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), .green: #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)]
    static var alpha: [Card.CardFill: CGFloat] = [.solid: 1.0, .outlined: 0.40, .striped: 0.15]
    static var strokeWidth: [Card.CardFill: CGFloat] = [.solid: -5, .outlined: 5, .striped: -5]
}
