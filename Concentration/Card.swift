//
//  Card.swift
//  Concentration
//
//  Created by user on 9/10/19.
//  Copyright © 2019 user. All rights reserved.
//

import Foundation

final class Card {
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    init(identifier: Int) {
        self.identifier = identifier
    }
}

