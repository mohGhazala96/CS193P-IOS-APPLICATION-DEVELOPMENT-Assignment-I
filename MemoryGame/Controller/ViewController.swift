//
//  ViewController.swift
//  MemoryGame
//
//  Created by Mohamed Aboughazala on 4/20/20.
//  Copyright © 2020 Mohamed Aboughazala. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var flipCountLabel: UILabel!{
        didSet{
            updateFlipCountLable()
            
        }
    }
    @IBAction func resartGame(_ sender: UIButton) {

        resetView()
        updateScore()
        updateFlipCountLable()
        
        for (card,_) in emojis{
            emojis[card] = nil
        }
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
            updateFlipCountLable()
        }
    }
    
    override func viewDidLayoutSubviews() { 
        restartButton.layer.cornerRadius = restartButton.frame.height * 0.50
        restartButton.layer.masksToBounds = true
    }
    
    // lazy(cant have did set) to allow the usage of an unintialized value in an intializer
    lazy var game=Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards:Int{
        return (cardButtons.count+1)/2
    }
    
    func updateScore(){
        scoreLabel.text = "Score: \(game.score)"
        
    }
    
    func updateFlipCountLable() {
        let attributes: [NSAttributedString.Key : Any] = [
            .backgroundColor: #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1),
            NSAttributedString.Key.foregroundColor : UIColor.black,
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.double.rawValue ]
        let attributedString = NSAttributedString(string: "Flips: \(game.flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attributedString
        
        
    }
    
    func resetView(){
        game.resetAllCards()
        for index in cardButtons.indices{
            let button = cardButtons[index]
            button.setTitle("", for: UIControl.State.normal)
            button.backgroundColor =  #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
        }
    }
    
    func updateViewFromModel(){
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp{
                button.setTitle(getEmoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }else{
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
                
            }
            
        }
        updateScore()
    }
    
    var emojis = [Card:String]()
    
    func getEmoji(for card:Card)->String{
        if emojis[card] == nil , game.currentTheme.count>0{
            
            let randomIndex = game.currentTheme.count.randomNumber
            emojis[card] = game.currentTheme.remove(at: randomIndex)
        }
        
        return emojis[card]  ?? "?"
    }
}

extension Int{
    var randomNumber: Int{
        
        return Int(arc4random_uniform(UInt32(self)))
    }
}
