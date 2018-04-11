//
//  ViewController.swift
//  memorygame
//
//  Created by Sara Lundberg on 4/3/18.
//  Copyright © 2018 Sara Lundberg. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var symbols = [
    "🤪",
    "🤣",
    "🤪",
    "🤣",
]
    var selectedCard: CardButton?
    
    
    @IBAction func flipCard(_ sender: CardButton) {
        
        let symbol = symbols[sender.tag]
        let senderTitle = sender.title(for: .normal)
        
        if senderTitle == nil || senderTitle == "" {
            if let card = selectedCard {
                if card.title(for: .normal) == symbol {
                    sender.setTitle(symbol, for: .normal)
                } else {
                    card.setTitle("", for: .normal)
                }
                selectedCard = nil
            } else {
                sender.setTitle(symbol, for: .normal)
                selectedCard = sender
            }
            
            
        }
}
}
