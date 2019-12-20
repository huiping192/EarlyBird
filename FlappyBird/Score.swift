//
//  Score.swift
//  FlappyBird
//
//  Created by Huiping Guo on 2019/12/20.
//  Copyright © 2019 Huiping Guo. All rights reserved.
//

import Foundation

struct Score {
    static func registerScore(_ score: Int) {
        if score > bestScore {
            bestScore = score
        }
    }
    
    static var bestScore: Int {
        get {
            return UserDefaults.standard.integer(forKey: "bestScore")
        }
        set {
            let userDefaults = UserDefaults.standard
            userDefaults.set(newValue, forKey: "bestScore")
            userDefaults.synchronize()
        }
    }
}
