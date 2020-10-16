//
//  Card.swift
//  Set
//
//  Created by Michael Kennecke on 7/8/19.
//  Copyright © 2019 Michael Kennecke. All rights reserved.
//

import Foundation

struct Card {
    
    var shapeId: Int
    var amountOfShapeId: Int
    var colorOfShapeId: Int
    var fillingLevelOfShapeId: Int
    var isMatched = false
    var isSelected = false
    
    var idValueMatrix: [Int] {
        return [shapeId, amountOfShapeId, colorOfShapeId, fillingLevelOfShapeId]
    }
    
    private static var factorySelector = 0
    private static var shapeIdFactory = 0
    private static var amountOfShapeIdFactory = 0
    private static var colorOfShapeIdFactory = 0
    private static var fillingLevelOfShapeIdFactory = 0
    
    init() {
        self.shapeId = Card.shapeIdFactory
        self.amountOfShapeId = Card.amountOfShapeIdFactory
        self.colorOfShapeId = Card.colorOfShapeIdFactory
        self.fillingLevelOfShapeId = Card.fillingLevelOfShapeIdFactory
        Card.createUniqueIdCombination()
    }
    
    private static func createUniqueIdCombination() {
        if(fillingLevelOfShapeIdFactory == 2) {
            fillingLevelOfShapeIdFactory = 0
            if(colorOfShapeIdFactory == 2) {
                colorOfShapeIdFactory = 0
                if(amountOfShapeIdFactory == 2) {
                    amountOfShapeIdFactory = 0
                    if (shapeIdFactory == 2) {
                        shapeIdFactory = 0
                    } else {
                        shapeIdFactory += 1
                    }
                } else {
                    amountOfShapeIdFactory += 1
                }
            } else {
                colorOfShapeIdFactory += 1
              }
        } else {
            fillingLevelOfShapeIdFactory += 1
          }
    }
}
