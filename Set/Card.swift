//
//  Card.swift
//  Set
//
//  Created by Omran Khoja on 8/6/19.
//  Copyright © 2019 AcronDesign. All rights reserved.
//

import Foundation

struct Card {
    var cardShape: CardShape
    var cardColor: CardColor
    var cardFill: CardFill
    var cardNumber: CardNumber
    var cardText = String()

    lazy var matrix = [cardColor.rawValue, cardNumber.rawValue, cardShape.rawValue, cardFill.rawValue] as [Any]

    enum CardShape: String, CustomStringConvertible, CaseIterable {
        case triangle = "triangle"
        case circle = "circle"
        case square = "square"
        var description: String {return rawValue}

    }

    enum CardColor: String, CustomStringConvertible, CaseIterable {
        case red = "red"
        case green = "green"
        case purple = "purple"
        var description: String {return rawValue}
    }

    enum CardFill: String, CustomStringConvertible, CaseIterable {
        case solid = "solid"
        case outlined = "outlined"
        case striped = "striped"
        var description: String {return rawValue}
    }

    enum CardNumber: Int, CustomStringConvertible, CaseIterable {
        case one = 1
        case two = 2
        case three = 3
        var description: String {return String(rawValue)}
    }


    // MARK: Initialize a Card
    init(with c: CardColor, _ n: CardNumber, _ f: CardFill, _ s: CardShape){
        cardColor = c
        cardShape = s
        cardNumber = n
        cardFill = f
    }
}

extension Card: CustomStringConvertible {

    var description: String {
        return "\(cardColor) \(cardNumber) \(cardShape) \(cardFill)"
    }

}

extension Card: Equatable {
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.cardColor == rhs.cardColor &&
                lhs.cardShape == rhs.cardShape &&
                lhs.cardNumber == rhs.cardNumber &&
                lhs.cardFill == rhs.cardFill
    }

}






//    func hash(into hasher: inout Hasher){
//        hasher.combine(cardColor)
//        hasher.combine(cardShade)
//        hasher.combine(cardNumber)
//    }
//
//    static func ==(lhs: Card, rhs: Card) -> Bool {
//        return lhs.cardColor == rhs.cardColor && lhs.cardNumber == rhs.cardNumber && lhs.cardShade == rhs.cardShade
//    }
//

//{
//    self.cardShape = CardShape.allCases.randomElement()!
//    self.cardColor = CardColor.allCases.randomElement()!
//    self.cardShade = CardShade.allCases.randomElement()!
//    self.cardNumber = CardNumber.allCases.randomElement()!
//
//    var cardNumber = Int()
//    if self.cardNumber == .One {
//        cardNumber = 1
//    } else if self.cardNumber ==  .Two {
//        cardNumber = 2
//    } else {
//        cardNumber = 3
//    }
//
//    if self.cardShape == .Square {
//        for _ in 1...cardNumber {
//            self.cardText.append("■")
//        }
//    } else if self.cardShape == .Circle {
//        for _ in 1...cardNumber {
//            self.cardText.append("●")
//        }
//    } else {
//        for _ in 1...cardNumber {
//            self.cardText.append("▲")
//        }
//    }
//
//}

//
//
//
//import Foundation
//
//struct Card {
//    var cardShape: CardShape
//    var cardColor: CardColor
//    var cardFill: CardFill
//    var cardNumber: CardNumber
//
//
//    enum CardShape: CaseIterable {
//        case triangle
//        case circle
//        case square
//
//    }
//
//    enum CardColor: CaseIterable {
//        case red
//        case green
//        case purple
//    }
//
//    enum CardFill: CaseIterable {
//        case solid
//        case outlined
//        case striped
//    }
//
//    enum CardNumber: CaseIterable {
//        case one
//        case two
//        case three
//    }
//
//
//    // MARK: Initialize a Card
//    init(with c: CardColor, _ n: CardNumber, _ f: CardFill, _ s: CardShape){
//        cardColor = c
//        cardShape = s
//        cardNumber = n
//        cardFill = f
//    }
//}
//
//extension Card: Equatable {
//    static func ==(lhs: Card, rhs: Card) -> Bool {
//        return lhs.cardColor == rhs.cardColor &&
//                lhs.cardShape == rhs.cardShape &&
//                lhs.cardNumber == rhs.cardNumber &&
//                lhs.cardFill == rhs.cardFill
//    }
//}
//
