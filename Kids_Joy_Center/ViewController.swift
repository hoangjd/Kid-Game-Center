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
    
   // var allHighScores = [HighScore](repeatElement(HighScore(gameType:), count: <#T##Int#>)//HighScore(gameType: "Memory", score: 0)
    
    var memoryHighScore = [HighScore](repeatElement(HighScore(gameType: "Memory", score: 0), count: 5))
    var sortingHighScore = [HighScore](repeatElement(HighScore(gameType: "Sort", score: 0), count: 5))
    var balloonHighScore = [HighScore](repeatElement(HighScore(gameType: "Balloon",score: 0), count: 5))
    var allHighScores: [[HighScore]]!
    var choice = GameAndDifficulty()

   // var rand = AllMemoryCards(difficulty: "Medium")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        allHighScores = [memoryHighScore, sortingHighScore, balloonHighScore]
        

            if let readAllHighScores = UserDefaults.standard.object(forKey: "allScores") as? Data {
                allHighScores = NSKeyedUnarchiver.unarchiveObject(with: readAllHighScores) as! [[HighScore]]
            }
        outputData()

        // Do any additional setup after loading the view, typically from a nib.
    }
    
//    func setHS() {
////        var game = "Memory"
////        var hs = 0
////
//        let newHS = HighScore(gameType: game, score: hs)
//        for i in 0..<allHighScores.count {
//            for j in 0..<allHighScores[i].count{
//                if i == 0 {
//                    allHighScores[i][j].game = "Memory"
//                } else if i == 1 {
//                    allHighScores[i][j].game = "Sort"
//                } else if i == 2 {
//                    allHighScores[i][j].game = "Balloon"
//                }
//            }
//        }
//
//    //    if newHS.gameType
//   //     allHighScores = (newHS)
//        updateDatabase()
//        outputData()
//
//    }
    
    func setHS() {
        for i in 0..<allHighScores.count {
            for j in 0..<allHighScores[i].count{
                if i == 0 {
                    let newHS = HighScore(gameType: "Memory", score: 0)
                    allHighScores[i][j] = newHS
                    updateDatabase()
                } else if i == 1 {
                    let newHS = HighScore(gameType: "Sort", score: 0)
                    allHighScores[i][j] = newHS
                    updateDatabase()
                } else if i == 2 {
                    let newHS = HighScore(gameType: "Balloon", score: 0)
                    allHighScores[i][j] = newHS
                    updateDatabase()
                }
            }
        }
        outputData()
        
    }
    
    func outputData() {
        for i in 0..<allHighScores.count {
            for j in 0..<allHighScores[i].count{
                print(allHighScores[i][j].game)
                print("\(allHighScores[i][j].score)")
            }
        }
    }
    
    func resetDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: "allScores")
        }
    }
    
    func updateDatabase(){
        let highScoreData = NSKeyedArchiver.archivedData(withRootObject: allHighScores)
        UserDefaults.standard.set(highScoreData, forKey: "allScores")
        UserDefaults.standard.synchronize()
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
        setHS()
//        print("\(allHighScores.game) \(allHighScores.score)")
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
        } else if game == "Sort" {
            performSegue(withIdentifier: "toSortingGame", sender: self)
        } else if game == "Balloon" {
            performSegue(withIdentifier: "toBalloonGame", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MemoryViewController{
            destination.title = "Memory"
            destination.ourDifficulty = choice
        }
        
        if let destination = segue.destination as? SortingViewController{
            destination.title = "Sort The Vehicles"
            destination.ourDifficulty = choice
        }
        
        if let destination = segue.destination as? BalloonViewController{
            destination.title = "Balloon Pop"
            destination.ourDifficulty = choice
        }
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension UIViewController{
    func resetView() {
        let parent = view.superview
        view.removeFromSuperview()
        view = nil
        parent?.addSubview(view)
    }
}

