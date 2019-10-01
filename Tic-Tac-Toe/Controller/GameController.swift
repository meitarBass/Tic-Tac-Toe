//
//  GameController.swift
//  Tic-Tac-Toe
//
//  Created by Meitar Basson on 01/10/2019.
//  Copyright © 2019 Meitar Basson. All rights reserved.
//

import UIKit

class GameController: UIViewController {
    
    var winningCombinations = [[0,1,2] ,[3,4,5], [6,7,8], [0,4,8], [3,4,6], [0,3,6], [1,4,7], [2,5,8]]
    var currentBoard = [["x","o","x"],["x","o","o"],["o","x","x"]] //
    var whoseTurn = 1 // Player 1 turn

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        print(getResult(board: currentBoard))
    }
    
    
    func checkIfWon() {
        
    }
    
    
    
    // MARK: Segues and transition between controllers
    @IBAction func ExitButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: {})
    }
    
    @IBAction func UndoButtonTapped(_ sender: UIButton) {
        // act like game done for now
        gameDone()
    }
    
    @IBAction func boardTapped(_ sender: UIButton) {
        print(sender.tag)
    }
    
    
    func gameDone() {
        performSegue(withIdentifier: "ToGameOver", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Detect who won
    }


}
