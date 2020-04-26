//
//  Card.swift
//  MemoryGame
//
//  Created by Mohamed Aboughazala on 4/20/20.
//  Copyright © 2020 Mohamed Aboughazala. All rights reserved.
//

import Foundation
struct Card:Hashable  {
    var isFaceUp=false
    var isMatched=false
    private var identifier:Int
    private static var idenitifierFactory = 0
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool{
        return lhs.identifier == rhs.identifier
    }
    
    private static func getUniqueIdentifier() ->Int{
        idenitifierFactory+=1
        return idenitifierFactory
    }
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
