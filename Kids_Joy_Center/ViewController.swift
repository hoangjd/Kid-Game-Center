//
//  ViewController.swift
//  Kids_Joy_Center
//
//  Created by Joseph Hoang on 3/16/18.
//  Copyright © 2018 Joe Hoang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var easyButton: UIButton!
    @IBOutlet weak var mediumButton: UIButton!
    @IBOutlet weak var hardButton: UIButton!
    
    @IBOutlet weak var memoryButton: UIButton!
    @IBOutlet weak var sortButton: UIButton!
    @IBOutlet weak var balloonButton: UIButton!
    
    var choice = GameAndDifficulty()

   // var rand = AllMemoryCards(difficulty: "Medium")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    @IBAction func memoryButtonPushed(_ sender: UIButton) {
        clearGameChoice()
        showGameChoice(sender)
        choice.game = "Memory"
    }
    
    @IBAction func sortButtonPushed(_ sender: UIButton) {
        clearGameChoice()
        showGameChoice(sender)
        choice.game = "Sort"
    }
    
    @IBAction func balloonButtonPushed(_ sender: UIButton) {
        clearGameChoice()
        showGameChoice(sender)
        choice.game = "Balloon"
    }
    
    @IBAction func easyButtonPushed(_ sender: UIButton) {
        choice.difficulty = "Easy"
        changeButtonText(sender)
    }
    
    @IBAction func mediumButtonPushed(_ sender: UIButton) {
        choice.difficulty = "Medium"
        changeButtonText(sender)
    }
    
    @IBAction func hardButtonPushed(_ sender: UIButton) {
        choice.difficulty = "Hard"
        changeButtonText(sender)
    }
    
    func showGameChoice(_ button: UIButton) {
        button.setTitle("Your Choice!", for: .normal)
    }
    
    func clearGameChoice() {
        memoryButton.setTitle(nil, for: .normal)
        sortButton.setTitle(nil, for: .normal)
        balloonButton.setTitle(nil, for: .normal)
    }
    
    func changeButtonText(_ button: UIButton){
        clearButtonColors()
        button.setTitleColor(UIColor.blue , for: .normal)

    }
    
    func clearButtonColors(){
        easyButton.setTitleColor(UIColor.white , for: .normal)
        mediumButton.setTitleColor(UIColor.white, for: .normal)
        hardButton.setTitleColor(UIColor.white , for: .normal)
    }
    

    @IBAction func playButtonPushed(_ sender: UIButton) {
      //  var ourChoices[[String]]
        if let game = choice.game, let difficulty = choice.difficulty{
            print("\(game) \(difficulty)")
            moveToGame(game)
//            moveToMemoryGame()
        } else {
            let alert = UIAlertController(title: "Error", message: "You must choose a game type and difficulty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
//    func moveToMemoryGame(){
//        let memoryView = MemoryViewController()
//        self.navigationController?.pushViewController(memoryView, animated: true)
//    }

    
    func moveToGame(_ game: String){
        if game == "Memory" {
            performSegue(withIdentifier: "toMemoryGame", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     //   if (segue.destination
        if let destination = segue.destination as? MemoryViewController{
            destination.title = "Memory"
            destination.ourDifficulty = choice
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

