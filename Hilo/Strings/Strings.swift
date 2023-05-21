//
//  Strings.swift
//  Hilo
//
//  Created by Yaroslav Sedyshev on 20.05.2023.
//

enum Strings {
    static let gameIntro = """
*****************************************************
***  HILO CONSOLE CARD GAME BY YAROSLAV SEDYSHEV  ***
*****************************************************
"""

    static let roundIntro = "********************** ROUND %d **********************"
    static let potStatusText = "[ POT: $%d ]"
    static let dealtCard = "[ %@ ]%@[ %d ]"
    static let nextCard = "NEXT CARD: [ %@ ]%@"
    static let makingStakes = "[ MAKING STAKES ... ]"
    static let skip = " EQUAL-RANK CARDS, SKIPPING TURN."
    static let winner = "%@ IS THE WINNER."
    static let tie = "IT'S A TIE! STARTING NEXT ROUND."
    static let guessPrompt = "%@: 'h' - hi OR 'l' - lo:"
    static let aiGuess = "%@:"
    static let wrongGuess = "%@: WRONG GUESS, YOU LOST!"
    
    static let absoluteWinner = """
*****************************************************
*** GAME OVER
*** AND THE WINNERS ARE:
*** %@
*****************************************************
"""
}
