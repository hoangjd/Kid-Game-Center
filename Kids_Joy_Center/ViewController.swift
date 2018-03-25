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
    var highScoreView = UIView(frame: CGRect(x: 300, y: 100, width: 400, height: 600))
    
    var memoryHighScore = [HighScore](repeatElement(HighScore(gameType: "Memory", score: 0), count: 5))
    var sortingHighScore = [HighScore](repeatElement(HighScore(gameType: "Sort", score: 0), count: 5))
    var balloonHighScore = [HighScore](repeatElement(HighScore(gameType: "Balloon",score: 0), count: 5))
    
    var allHighScores: [[HighScore]]!
    var choice = GameAndDifficulty()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        allHighScores = [memoryHighScore, sortingHighScore, balloonHighScore]

            if let readAllHighScores = UserDefaults.standard.object(forKey: "allScores") as? Data {
                allHighScores = NSKeyedUnarchiver.unarchiveObject(with: readAllHighScores) as! [[HighScore]]
            } else {
                setHS()
            }


        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let readAllHighScores = UserDefaults.standard.object(forKey: "allScores") as? Data {
            allHighScores = NSKeyedUnarchiver.unarchiveObject(with: readAllHighScores) as! [[HighScore]]
        } else {
            setHS()
        }

    }
    
    func LoadHighScoreView() {
        highScoreView = UIView(frame: CGRect(x: 300, y: 100, width: 400, height: 600))
        highScoreView.backgroundColor = UIColor(red: 255/255, green: 250/255, blue: 250/255, alpha: 0.92)
    //    highScoreView.backgroundColor = UIColor(displayP3Red: 255/255, green: 255/255, blue: 255/255, alpha: 0.95)
        self.view.addSubview(highScoreView)
        
        let highScoreExit = UIButton(frame: CGRect(x: 20, y: 20, width: 60, height: 30))
        highScoreExit.setTitle("Close", for: .normal)
        highScoreExit.setTitleColor(UIColor.green, for: .normal)
  //      highScoreExit.backgroundColor = UIColor.black
        highScoreExit.addTarget(self, action: #selector(removeScores(sender:)), for: .touchUpInside)
        highScoreView.addSubview(highScoreExit)
        
        highScoreView.addSubview(createLabel(word: "HighScores", yLocation: 30))
        highScoreView.addSubview(createLabel(word: "Memory", yLocation: 60))
        highScoreView.addSubview(createLabel(word: "Sort", yLocation: 230))
        highScoreView.addSubview(createLabel(word: "Balloon", yLocation: 410))
        

        
        displayScore(gameType: 0, Location: 85, view: highScoreView) //memory
        displayScore(gameType: 1, Location: 255, view: highScoreView) //sort
        displayScore(gameType: 2, Location: 435, view: highScoreView) //balloon
        
        
    }
    
    @objc func removeScores(sender: UIButton) {
        highScoreView.removeFromSuperview()
    }
    @IBAction func displayScores(_ sender: UIBarButtonItem) {
        if !highScoreView.isDescendant(of: self.view){
            LoadHighScoreView()
        }
    }
    
    func createLabel(word: String, yLocation: Int) -> UILabel {
        let highScoreLabel = UILabel(frame: CGRect(x: 100, y: yLocation, width: 200, height: 30))
        highScoreLabel.textAlignment = .center
        highScoreLabel.text = word
        return highScoreLabel
    }
    
    func displayScore(gameType: Int, Location: Int, view: UIView) {
        for i in 0..<5 {
            let currentScore = String(describing: allHighScores[gameType][i].score)
            view.addSubview(createLabel(word:currentScore, yLocation: Location + (i*25)))
        }
    }
    
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
        UserDefaults.standard.removeObject(forKey: "allScores")
        UserDefaults.standard.synchronize()
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

        if let game = choice.game, let difficulty = choice.difficulty{
            print("\(game) \(difficulty)")
            moveToGame(game)
        } else {
            let alert = UIAlertController(title: "Error", message: "You must choose a game type and difficulty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    

    
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
            destination.highScoreList = allHighScores
        }
        
        if let destination = segue.destination as? SortingViewController{
            destination.title = "Sort The Vehicles"
            destination.ourDifficulty = choice
            destination.highScoreList = allHighScores
        }
        
        if let destination = segue.destination as? BalloonViewController{
            destination.title = "Balloon Pop"
            destination.ourDifficulty = choice
            destination.highScoreList = allHighScores
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

