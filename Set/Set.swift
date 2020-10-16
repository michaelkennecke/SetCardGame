//
//  Set.swift
//  Set
//
//  Created by Michael Kennecke on 7/8/19.
//  Copyright © 2019 Michael Kennecke. All rights reserved.
//

import Foundation

struct Set {
    
    var unshuffledCardDeck = Array<Card>()
    var cardDeck = Array<Card>()
    var cardsOnTable = Array<Card>()
    var indexOfFirstSelectedCard: Int?
    var indexOfSecondSelctedCard: Int?
    
    init() {
        for _ in 1...81 {
            let card = Card()
            unshuffledCardDeck.append(card)
        }
        shuffleCardDeck()
        cardsOnTable.append(contentsOf: drawCards(n: 12))
    }
    
    private mutating func shuffleCardDeck() {
        for _ in 0...(unshuffledCardDeck.count-1) {
            let randomIndex = Int(arc4random_uniform(UInt32(unshuffledCardDeck.count)))
            cardDeck.append(unshuffledCardDeck[randomIndex])
            unshuffledCardDeck.remove(at: randomIndex)
        }
    }
    
    private mutating func drawCards(n: Int) -> Array<Card> {
        var cards = Array<Card>()
        for _ in 0...n-1 {
            cards.append(cardDeck.remove(at: 0))
        }
        return cards
    }
    
    mutating func chooseCard(at index: Int) {
        if let firstMatchIndex = indexOfFirstSelectedCard {
            if(firstMatchIndex == index) {
                indexOfFirstSelectedCard = nil
                cardsOnTable[index].isSelected = false
                return
            }
            if let secondMatchIndex = indexOfSecondSelctedCard {
                if(secondMatchIndex == index) {
                    indexOfSecondSelctedCard = nil
                    cardsOnTable[index].isSelected = false
                    return
                }
                let sumIdMatrix = createSumIdMatrixBasedOn(first: firstMatchIndex, second: secondMatchIndex, third: index)
                if isSet(for: sumIdMatrix) {
                    indexOfFirstSelectedCard = nil
                    indexOfSecondSelctedCard = nil
                    cardsOnTable[firstMatchIndex].isMatched = true
                    cardsOnTable[secondMatchIndex].isMatched = true
                    cardsOnTable[index].isMatched = true
                    if(cardDeck.count <= 0) {
                        return
                    } else {
                        var drawedCards = drawCards(n: 3)
                        cardsOnTable[firstMatchIndex] = drawedCards.remove(at: 0)
                        cardsOnTable[secondMatchIndex] = drawedCards.remove(at: 0)
                        cardsOnTable[index] = drawedCards.remove(at: 0)
                    }
                } else {
                    indexOfFirstSelectedCard = nil
                    indexOfSecondSelctedCard = nil
                    cardsOnTable[firstMatchIndex].isSelected = false
                    cardsOnTable[secondMatchIndex].isSelected = false
                }
            } else {
                indexOfSecondSelctedCard = index
                cardsOnTable[index].isSelected = true
            }
        } else {
            indexOfFirstSelectedCard = index
            cardsOnTable[index].isSelected = true
        }
    }
    
    mutating func createSumIdMatrixBasedOn(first firstMatchIndex: Int, second secondMatchIndex: Int, third thirdMatchIndex: Int) -> Array<Int> {
        var sumIdMatrix = Array<Int>()
        for i in 0...(cardsOnTable[firstMatchIndex].idValueMatrix.count-1) {
            sumIdMatrix.append(cardsOnTable[firstMatchIndex].idValueMatrix[i] + cardsOnTable[secondMatchIndex].idValueMatrix[i] + cardsOnTable[thirdMatchIndex].idValueMatrix[i])
        }
        return sumIdMatrix
    }
    
    mutating func isSet(for sumIdMatrix: Array<Int>) -> Bool {
        for i in 0...(sumIdMatrix.count-1) {
            if(!(sumIdMatrix[i] == 0 || sumIdMatrix[i] == 3 || sumIdMatrix[i] == 6)) {
                return false;
            }
        }
        return true
    }
    
    func printCardDeck() {
        for card in cardDeck {
            print(card)
        }
        print(cardDeck.count)
    }
    
    func printCardsOnTable() {
        for card in cardsOnTable {
            print(card)
        }
        print(cardsOnTable.count)
    }
    
}
