//
//  ViewController.swift
//  Set
//
//  Created by Michael Kennecke on 7/7/19.
//  Copyright © 2019 Michael Kennecke. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var shapeChoices = ["■", "●", "▲"]
    private var shapeAmountChoices = [1, 2, 3]
    private var shapeColorChoices = [#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)]
    private var shapeFillingLevelChoices = [0.18, 1.0, 0.99]
    
    lazy var game: Set = Set()
    
    @IBAction func newGame(_ sender: UIButton) {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            button.isEnabled = true
        }
        game =  Set()
        game.printCardsOnTable()
        game.printCardDeck()
        updateViewFromModel()
    }
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let index = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: index)
            updateViewFromModel()
        }
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cardsOnTable[index]
            button.setAttributedTitle(shape(for: card), for: UIControl.State.normal)
            if card.isSelected {
                button.layer.borderWidth = 3.0
                button.layer.borderColor = UIColor.orange.cgColor
            } else {
                button.layer.borderWidth = 0.0
                button.layer.borderColor = UIColor.white.cgColor
            }
            if card.isMatched {
                button.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 0)
                button.layer.borderWidth = 0.0
                button.layer.borderColor = UIColor.white.cgColor
                button.setAttributedTitle(NSAttributedString(string: " "), for: UIControl.State.normal)
                button.setTitle(" ", for: UIControl.State.normal)
                button.isEnabled = false
            }
           
        }
    }
    
    func shape(for card: Card) -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: shapeColorChoices[card.colorOfShapeId].withAlphaComponent(CGFloat(shapeFillingLevelChoices[card.fillingLevelOfShapeId]))
        ]
        var tempShape = shapeChoices[card.shapeId]
        for _ in 1..<shapeAmountChoices[card.amountOfShapeId] {
            tempShape = tempShape + "\n" + shapeChoices[card.shapeId]
        }
        let resultShape = NSMutableAttributedString(string: tempShape, attributes: attributes)
        if(shapeFillingLevelChoices[card.fillingLevelOfShapeId] == 0.99) {
           resultShape.addAttribute(.strokeWidth, value: 5, range: NSRange(location: 0, length: resultShape.string.count))
        }
        return resultShape
    }
    
}

