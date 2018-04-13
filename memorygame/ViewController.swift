//
//  ViewController.swift
//  memorygame
//
//  Created by Sara Lundberg on 4/3/18.
//  Copyright © 2018 Sara Lundberg. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        unOrderSymbols()
    }
    
    
    @IBOutlet weak var card1: CardButton!
    @IBOutlet weak var card2: CardButton!
    @IBOutlet weak var card3: CardButton!
    @IBOutlet weak var card4: CardButton!
    
    
    lazy var buttons: [CardButton] = [card1, card2, card3, card4]
    
    var firstCard = ""
    var secondCard = ""
    
    var cardOne: CardButton? = nil
    var cardTwo: CardButton? = nil
    
    var score = 0
    var unOrderCard = [String]()
    
    let yellowBg = UIColor(red: 252.0/255.0, green: 214.0/255.0, blue: 51.0/255.0, alpha: 1.0)
    let turquoiseBg = UIColor(red: 32.0/255.0, green: 183.0/255.0, blue: 164.0/255.0, alpha: 1.0)
    let defaultColor = UIColor(red: 192.0/255.0, green: 164.0/255.0, blue: 252.0/255.0, alpha: 1.0)

    let symbols = [
        "🤪","🤪",
        "😂","😂",
        ]
    
    
    func unOrderSymbols() {
        var symbolsCopy = symbols
        var unOrderArray = [String]()
        var randomNum: Int
        for _ in symbols {
            randomNum = (
                Int(arc4random_uniform(
                    UInt32(symbolsCopy.count)
                )))
            unOrderArray.append(symbolsCopy[randomNum])
            symbolsCopy.remove(at: randomNum)
        }
        unOrderCard = unOrderArray
    }
    
    
    func resetCards() {
        firstCard = ""
        secondCard = ""
        cardOne = nil
        cardTwo = nil
    }
    
    
    
    func resetGame() {
        unOrderSymbols()
        resetCards()
        score = 0
        for (i, _) in buttons.enumerated() {
            buttons[i].isEnabled = true
            buttons[i].setTitle("", for: .normal)
            buttons[i].backgroundColor = defaultColor
        }
    }
    
    
    func displayAlert(_ title: String,_ msg: String) {
        let alert = UIAlertController(
            title: title,
            message: msg,
            preferredStyle: UIAlertControllerStyle.alert
        )
        alert.addAction(
            UIAlertAction(
                title: "Play Again",
                style: UIAlertActionStyle.default,
                handler: { action in
                    self.resetGame()
            }))
        self.present(alert, animated: true, completion: nil)
    }
    

    func ifWinner() {
        if score >= 2 {
            displayAlert("AMAZING!", "You are the winner")
        }
    }
    
    
    func matchingCards() {
        if firstCard == secondCard {
            score += 1
            cardOne?.isEnabled = false
            cardTwo?.isEnabled = false
            ifWinner()
            resetCards()
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.cardOne?.setTitle("",for: .normal)
                self.cardTwo?.setTitle("",for: .normal)
                self.cardOne?.backgroundColor = self.defaultColor
                self.cardTwo?.backgroundColor = self.defaultColor
                self.resetCards()
            }
        }
    }
    
    
    
    
    func changeBg(_ symbol: String,_ card: CardButton) {
        switch symbol {
        case "🤪":
            card.backgroundColor = yellowBg
        case "😂":
            card.backgroundColor = turquoiseBg
        default:
            break
        }
    }
    
    
    
    @IBAction func flipCard(_ sender: CardButton) {
        
        let cardIndex = sender.tag
        let symbol = unOrderCard[cardIndex]
        if firstCard == "" {
            firstCard = symbol
            sender.setTitle(firstCard, for: .normal)
            cardOne = sender
            changeBg(firstCard, sender)
        } else if sender != cardOne && secondCard == "" {
            secondCard = symbol
            sender.setTitle(secondCard, for: .normal)
            cardTwo = sender
            changeBg(secondCard, sender)
            matchingCards()
        }
        
        
    }
}

