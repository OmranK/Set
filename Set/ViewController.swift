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
    @IBOutlet var setCardButtons: [UIButton]!
    private var selectedButtons = [UIButton]()
    private var activeCardButtons = 12
    
    @IBOutlet weak var alertLabel: UILabel!
    @IBOutlet weak var deckCountLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBAction func newGameButtonPressed(_ sender: UIButton) {
        setUpGame()
    }
    
    @IBAction func dealThreeButtonPressed(_ sender: UIButton) {
        if game.setCardDeck.count > 0 && game.cardsOnTheTable.count < 24 {
            activeCardButtons += 3
            game.draw()
            updateView()
        } else {
            alertLabel.text = ("No more cards to Draw.")
        }
    }
    
    @IBAction func cardButtonPressed(_ sender: UIButton) {
        if let cardIndex = setCardButtons.firstIndex(of: sender) {
            chooseButton(at: sender, index: cardIndex)
            updateView()
        }
    }
    
    private func chooseButton(at card: UIButton, index: Int) {
        
        func resetCards() {
            game.resetCards()
            if game.setCardDeck.count == 0 {
                if game.selectedCardsAreASet {
                    activeCardButtons -= 3
                    for index in activeCardButtons ... activeCardButtons + 3 {
                        setCardButtons[index].isHidden = true
                    }
                }
            }
            setCardButtons.forEach() { $0.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) }
            selectedButtons.removeAll()
            
        }
        
        func deselectCard() {
            card.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            card.layer.borderWidth = 3.0
            selectedButtons.remove(at: selectedButtons.firstIndex(of: card)!)
            game.deSelectCard(at: index)
        }
        
        func selectCard(){
            card.layer.borderColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
            card.layer.borderWidth = 3.0
            game.selectCard(at: index)
            alertLabel.text = "Sets Found: \(game.setCount)"
        }
        
        if selectedButtons.contains(card) {
            deselectCard()
            return
        } else {
            selectedButtons.append(card)
            selectCard()
        }

        if selectedButtons.count == 3 {
            resetCards()
            if game.selectedCardsAreASet {
                alertLabel.text = "That's a set! =)"
            } else {
                alertLabel.text = "Not a set! =("
            }
        }
    }
    
    
    //MARK: UI Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpGame()
    }
    
    private func setUpGame() {
        game = Game()
        activeCardButtons = 11
        for button in setCardButtons {
            button.isHidden = true
        }
        updateView()
    }
    
    private func updateView() {
        
        for index in 0...(activeCardButtons){
            let button = setCardButtons[index]
            let card = game.cardsOnTheTable[index]
            button.setAttributedTitle(setCardTitle(with: card), for: .normal)
            button.isHidden = false
        }
        print("Cards on the table: \(game.cardsOnTheTable.count)")
        
        scoreLabel.text = "Score: \(game.score)"
        deckCountLabel.text = "Deck Count: \(game.setCardDeck.count)"
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


//class ViewController: UIViewController {
//
//    private lazy var game = Game()
//    @IBOutlet var setCardButtons: [UIButton]!
//    private var selectedButtons = [UIButton]()
//    private var activeCardButtons = 11
//
//    @IBOutlet weak var alertLabel: UILabel!
//    @IBOutlet weak var deckCountLabel: UILabel!
//    @IBOutlet weak var scoreLabel: UILabel!
//
//    @IBAction func newGameButtonPressed(_ sender: UIButton) {
//        setUpGame()
//    }
//
//    @IBAction func dealThreeButtonPressed(_ sender: UIButton) {
//        if game.cardsOnTheTable.count < 24 {
//            game.draw()
//            addGameCards()
//            updateView()
//        }
//    }
//
//    @IBAction func cardButtonPressed(_ sender: UIButton) {
//        if let cardIndex = setCardButtons.firstIndex(of: sender) {
//            chooseButton(at: sender, index: cardIndex)
//            updateView()
//        }
//    }
//
//    private func chooseButton(at card: UIButton, index: Int) {
//
//        func resetCards() {
//            setCardButtons.forEach() { $0.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) }
//            selectedButtons.removeAll()
//            game.resetCards(at: index)
//        }
//
//        func deselectCard() {
//            card.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
//            card.layer.borderWidth = 3.0
//            selectedButtons.remove(at: selectedButtons.firstIndex(of: card)!)
//            game.deSelectCard(at: index)
//        }
//
//        func selectCard(){
//            card.layer.borderColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
//            card.layer.borderWidth = 3.0
//            game.selectCard(at: index)
//            alertLabel.text = "Sets Found: \(game.setCount)"
//        }
//
//        if selectedButtons.contains(card) {
//            deselectCard()
//            return
//        } else {
//            selectedButtons.append(card)
//            selectCard()
//
//        }
//
//        if selectedButtons.count == 3 {
//            resetCards()
//            if game.selectedCardsAreASet {
//                alertLabel.text = "That's a set! =)"
//            } else {
//                alertLabel.text = "Not a set! =("
//            }
//
//        }
//
//    }
//
//    private func addGameCards(){
//        if activeCardButtons < 23 {
//            activeCardButtons += 3
//            updateView()
//        }
//    }
//
//    private func removeCardButtons() {
//        activeCardButtons -= 3
//        updateView()
//    }
//
//    //MARK: UI Setup
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//        setUpGame()
//    }
//
//    private func setUpGame() {
//        game = Game()
//        activeCardButtons = 11
//        for button in setCardButtons {
//            button.isHidden = true
//        }
//        updateView()
//    }
//
//    private func updateView() {
//        for index in 0...activeCardButtons{
//            print(game.cardsOnTheTable.count)
//            let button = setCardButtons[index]
//            let card = game.cardsOnTheTable[index]
//            button.setAttributedTitle(setCardTitle(with: card), for: .normal)
//            button.isHidden = false
//        }
//
//        scoreLabel.text = "Score: \(game.score)"
//        deckCountLabel.text = "Deck Count: \(game.setCardDeck.count)"
//    }
//
//    private func setCardTitle(with card: Card) -> NSAttributedString {
//        var cardTitle = String()
//        if let shape = ModelToView.shapes[card.cardShape] {
//            cardTitle = shape
//            switch card.cardNumber {
//            case .two: cardTitle.append(" \(shape)")
//            case .three: cardTitle.append(" \(shape) \(shape)")
//            default:
//                break
//            }
//        }
//        let attributes: [NSAttributedString.Key : Any] = [
//            .strokeColor: ModelToView.colors[card.cardColor]!,
//            .strokeWidth: ModelToView.strokeWidth[card.cardFill]!,
//            .foregroundColor: ModelToView.colors[card.cardColor]!.withAlphaComponent(ModelToView.alpha[card.cardFill]!),
//        ]
//        return NSAttributedString(string: cardTitle, attributes: attributes)
//    }
//}
