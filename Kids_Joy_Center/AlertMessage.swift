//
//  AlertMessage.swift
//  Kids_Joy_Center
//
//  Created by Joseph Hoang on 3/23/18.
//  Copyright © 2018 Joe Hoang. All rights reserved.
//

import Foundation
import UIKit

class AlertMessage {
    var viewController: UIViewController?
    var score = 0
    init(viewController: UIViewController, score: Int){
        self.viewController = viewController
        self.score = score
    }
    
    func endTimeAlert() {
        let alert = UIAlertController(title: "GAME OVER", message: "Times UP", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Play Again", style: .default, handler: { action in
            self.viewController!.resetView()
        }))
        alert.addAction(UIAlertAction(title: "Go Back", style: .cancel, handler: { action in
            _ = self.viewController!.navigationController?.popViewController(animated: true)
        }))
        self.viewController!.present(alert, animated: true, completion: nil)
    }
    
    func presentWinAlert() {
        let alert = UIAlertController(title: "You Win", message: "Score: \(score)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Go Back", style: .cancel, handler: { action in
            _ = self.viewController!.navigationController?.popViewController(animated: true)
            
        }))
        alert.addAction(UIAlertAction(title:"Play Again" , style: .default, handler: { action in
            self.viewController!.resetView()
        }))
        self.viewController!.present(alert, animated: true, completion: nil)
    }
}
