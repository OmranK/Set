//
//  Game.swift
//  Set
//
//  Created by Omran Khoja on 8/6/19.
//  Copyright © 2019 AcronDesign. All rights reserved.
//

import Foundation

struct Game {
    
    private(set) var score = 0
    private(set) var setCardDeck = [Card]()
    
    private(set) var cardsOnTheTable = [Card]()
    private var selectedCards = [Card]()
    private var selectedCardIndices = [Int]()
    private(set) var selectedCardsAreASet = Bool()
    
    
    mutating func chooseCard(at index: Int){
        
        //FIX Not registering duplicates
        
        if selectedCardIndices.count < 3 {
            
            if selectedCardIndices.contains(index) {
                selectedCardIndices.remove(at: selectedCardIndices.firstIndex(of: index)!)
                selectedCards.remove(at: selectedCards.firstIndex(of: cardsOnTheTable[index])!)
                print([selectedCards.description])
                return
            }  else {
                selectedCardIndices.append(index)
                selectedCards.append(cardsOnTheTable[index])
                print([selectedCards.description])
            }
        }
        
        if selectedCardIndices.count == 3 {
            if isASet(with: selectedCards) {
                print("That's a set! =)")
                selectedCardsAreASet = true
                for index in selectedCardIndices {
                    cardsOnTheTable.remove(at: index)
                }
                selectedCardIndices.removeAll()
                selectedCards.removeAll()
                draw()
                score += 5
                return
            } else {
                selectedCardIndices.removeAll()
                selectedCards.removeAll()
                score -= 1
                print("That's not a set! =(")
                selectedCardsAreASet = false
            }
        }
    }
    
    func isASet(with selectedCards: [Card]) -> Bool {
        let color = Set(selectedCards.map{$0.cardColor}).count
        let shape = Set(selectedCards.map{$0.cardShape}).count
        let number = Set(selectedCards.map{$0.cardNumber}).count
        let fill = Set(selectedCards.map{$0.cardFill}).count
        
        return color != 2 && shape != 2 && number != 2 && fill != 2
    }
    
    mutating func draw() {
        if setCardDeck.count > 0 {
            for _ in 1...3 {
                 cardsOnTheTable += [setCardDeck.remove(at: setCardDeck.randomIndex)]
            }
        }
    }
    
    private mutating func initTable() {
        for _ in 1...4 {
            draw()
        }
    }
    
    // MARK: Initialize Game
    init() {
        for _ in 1...83 {
            let color = Card.CardColor.allCases.randomElement()!
            let number = Card.CardNumber.allCases.randomElement()!
            let fill = Card.CardFill.allCases.randomElement()!
            let shape = Card.CardShape.allCases.randomElement()!
            setCardDeck.append(Card(with: color, number, fill, shape))
        }
        initTable()
    }
}

extension Array {
    var randomIndex: Int {
        return Int(arc4random_uniform(UInt32(count - 1)))
    }
}
