//
//  Game+Helpers.swift
//  Hilo
//
//  Created by Yaroslav Sedyshev on 21.05.2023.
//

extension Game {
    func higherOrLowerSign(_ previousCard: Card?, _ nextCard: Card) -> String {
        guard let previousCard = previousCard else {
            return ""
        }
        
        if previousCard > nextCard {
            return "[ ↓ ]"
        } else {
            return "[ ↑ ]"
        }
    }
}
