//
//  Concentration.swift
//  MemoryGame
//
//  Created by Mohamed Aboughazala on 4/20/20.
//  Copyright © 2020 Mohamed Aboughazala. All rights reserved.
//

import Foundation
class Concentration{
    var cards:[Card] = [Card]()
    var score = 0
    var flipCount = 0
    let postiveScore = 2
    let negativeScore = -2
    var theme = Theme()
    var currentTheme:[String] = [String]()
    var indexCurrentFaceUpCard:Int?{
        get{
            return  cards.indices.filter{cards[$0].isFaceUp}.oneAndOnly
        }
        set(newValue){
            for flipDownIndex in cards.indices {
                cards[flipDownIndex].isFaceUp = (flipDownIndex == newValue)
            }
        }
    }
    
    func resetAllCards() {
        for flipDownIndex in cards.indices {
            cards[flipDownIndex].isFaceUp = false
            cards[flipDownIndex].isMatched = false
        }
        cards.shuffle()
        flipCount=0
        score = 0
        currentTheme = theme.getRandomTheme()
        
    }

    
    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index),"Index \(index) is not found in the Cards Array")
        if !cards[index].isMatched {
            if let matchIndex = indexCurrentFaceUpCard {
                if matchIndex != index {
                    //if cards match
                    if cards[matchIndex] == cards[index] {
                        cards[matchIndex].isMatched = true
                        cards[index].isMatched = true
                        score += postiveScore
                    }else{
                        score = (score + negativeScore) >= 0 ? score + negativeScore :0
                    }
                    
                    cards[index].isFaceUp = true
                    
                }
            }
            else {
                indexCurrentFaceUpCard = index
            }
        }
        flipCount+=1
    }
    
    init(numberOfPairsOfCards: Int){
        
        assert(numberOfPairsOfCards>0,"You must have at least one pair of cards")
        
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards.append(card)
            cards.append(card)
        }
        
        cards.shuffle()
        currentTheme = theme.getRandomTheme()
    }
}

extension Collection{
    var oneAndOnly: Element?{
        return count == 1 ? first : nil
    }
}
