//
//  GameController.swift
//  Tic-Tac-Toe
//
//  Created by Meitar Basson on 01/10/2019.
//  Copyright © 2019 Meitar Basson. All rights reserved.
//

import UIKit

class GameController: UIViewController {
    
    // Views with tap gesture instead of buttons?
    
    @IBOutlet var boardButtonsCollection: [UIButton]!
    var currentBoard: [[Shape]] = [[.E, .E, .E],[.E, .E, .E],[.E, .E, .E]]
    
    var playingShape: Shape = .X // Player 1 turn
    var winner: WINNER!

    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    
    // MARK: Computer Play
    
    func playComputer(playingShape: Shape) {
        let bestPlay = checkBestPlay(board: currentBoard, shape: playingShape)
        let buttonIndex = bestPlay.0 * 3 + bestPlay.1
        
        // Repeating this part in the player play also, need to make it a function
        currentBoard[bestPlay.0][bestPlay.1] = playingShape
        boardButtonsCollection[buttonIndex].setImage(UIImage(named: playingShape.rawValue.capitalized), for: .normal)
        switch getState(board: currentBoard, playerShape: playingShape) {
        case .PLAYING_USER_WON:
            winner = .PLAYER_2
            gameDone()
        case .TIE:
            winner = .TIE
            gameDone()
        case .INCOMPLETE: break
        }
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
        // Might have a shorter way to convert it!
        // Probably something like x % 3 = a, y = x / a
        var playedIndex = (-1,-1)
            switch sender.tag {
            case 1:
                playedIndex = (0,0)
            case 2:
                playedIndex = (0,1)
            case 3:
                playedIndex = (0,2)
            case 4:
                playedIndex = (1,0)
            case 5:
                playedIndex = (1,1)
            case 6:
                playedIndex = (1,2)
            case 7:
                playedIndex = (2,0)
            case 8:
                playedIndex = (2,1)
            case 9:
                playedIndex = (2,2)
            default:break
        }
        
        if currentBoard[playedIndex.0][playedIndex.1] == .E {
            currentBoard[playedIndex.0][playedIndex.1] = playingShape
            boardButtonsCollection[sender.tag - 1].setImage(UIImage(named: playingShape.rawValue.capitalized), for: .normal)
            switch getState(board: currentBoard, playerShape: playingShape) {
            case .PLAYING_USER_WON:
                winner = .PLAYER_1
                gameDone()
            case .TIE:
                winner = .TIE
                gameDone()
            case .INCOMPLETE: break
            }
        }
        
        playComputer(playingShape: .O)
        
    }
    
    
    func gameDone() {
        performSegue(withIdentifier: "ToGameOver", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Detect who won
        if segue.destination is GameOverController {
            let gameOverController = segue.destination as? GameOverController
            gameOverController?.winner = winner
        }
        
    }


}
