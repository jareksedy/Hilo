//
//  main.swift
//  Hilo
//
//  Created by Yaroslav Sedyshev on 18.05.2023.
//

import Foundation

var player = HumanPlayer()

print("Your prediction: \(player.makePrediction(by: Card(.ace, of: .spades)))")
