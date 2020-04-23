//
//  ThemeChooser.swift
//  MemoryGame
//
//  Created by Mohamed Aboughazala on 4/23/20.
//  Copyright © 2020 Mohamed Aboughazala. All rights reserved.
//

import Foundation
struct Theme{
   private(set) var themes:[[String]] = [ ["🎅", "🤶", "🧝", "🧦", "🦌", "🍪", "🥛", "🍷", "🌟", "❄", "⛄","🎄"],
                              ["😀", "😁", "😂", "🤣", "😃", "😄", "😅", "😆", "😉", "😊", "😋", "😎"]
                            ,[ "🦒", "🐘", "🦏", "🐭", "🐁", "🐀", "🐹", "🐰", "🐇", "🐿","🦔", "🦇"]]
    
    mutating func insertTheme(withTheme theme:[String]){
        themes.insert(theme, at: themes.endIndex)
        
    }
    
    mutating func getRandomTheme() -> [String] {
        return themes[themes.count.randomNumber]
    }
    
}
