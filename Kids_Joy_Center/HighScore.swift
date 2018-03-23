//
//  HighScore.swift
//  Kids_Joy_Center
//
//  Created by Joseph Hoang on 3/23/18.
//  Copyright © 2018 Joe Hoang. All rights reserved.
//

import Foundation

class HighScore: NSObject, NSCoding {
    
    var score: Int
    var game: String
    
    init(gameType: String, score: Int){
        self.game = gameType
        self.score = score
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(game, forKey: "Game")
        aCoder.encodeCInt(Int32(score), forKey: "Score")
    }
    
    required init?(coder aDecoder: NSCoder) {
        game = aDecoder.decodeObject(forKey: "Game") as! String
        score = aDecoder.decodeInteger(forKey:"Score")
    }
}
