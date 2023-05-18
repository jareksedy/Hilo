//
//  Cards.swift
//  Hilo
//
//  Created by Yaroslav Sedyshev on 18.05.2023.
//

enum CardSuits: String, CaseIterable {
    case hearts = "♥", diamonds = "♦", clubs = "♣", spades = "♠"
}

enum CardRanks: Int, CaseIterable {
    case ace = 1, two, three, four, five, six, seven, eight, nine, ten, jack, queen, king
    var stringValue: String {
        if (2...10).contains(self.rawValue) {
            return String(self.rawValue)
        } else {
            return String(describing: self).prefix(1).uppercased()
        }
    }
}

protocol DeckProtocol {
    var cards: [Card] { get }
    
    mutating func createAndShuffle()
    mutating func pop() -> Card?
}

struct Card: CustomStringConvertible {
    let rank: CardRanks
    let suit: CardSuits
    
    init(rank: CardRanks, of suit: CardSuits) {
        self.rank = rank
        self.suit = suit
    }
    
    var description: String {
        return "\(rank.stringValue)\(suit.rawValue)"
    }
}

struct Deck: DeckProtocol {
    var cards = [Card]()
    
    init() {
        createAndShuffle()
    }
    
    mutating func createAndShuffle() {
        cards.removeAll()
        for rank in CardRanks.allCases {
            for suit in CardSuits.allCases {
                cards.append(Card(rank: rank, of: suit))
            }
        }
        cards.shuffle()
    }
    
    mutating func pop() -> Card? {
        return cards.popLast()
    }
}
