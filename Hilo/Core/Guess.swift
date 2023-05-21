//
//  Guess.swift
//  Hilo
//
//  Created by Yaroslav Sedyshev on 21.05.2023.
//

enum Guess: String {
    case hi = "h", lo = "l"
    
    static func random() -> Self {
        return Bool.random() ? .hi : .lo
    }
}
