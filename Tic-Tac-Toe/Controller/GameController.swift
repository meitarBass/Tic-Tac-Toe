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
    
    // @IBOutlet var boardButtonsCollection: [UIButton]!
    @IBOutlet var boardImageCollection: [UIImageView]!
    var currentBoard: [[Shape]] = [[.E, .E, .E],[.E, .E, .E],[.E, .E, .E]]
    
    var playingShape: Shape = .X // Player 1 turn
    var winner: WINNER = .NONE

    override func viewDidLoad() {
        super.viewDidLoad()
                
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reset()
    }
    
    // MARK: Computer Play
    
    func playComputer(playingShape: Shape) {
        let bestPlay = checkBestPlay(board: currentBoard, shape: playingShape)
        let imageIndex = bestPlay.0 * 3 + bestPlay.1
        
        // Repeating this part in the player play also, need to make it a function
        currentBoard[bestPlay.0][bestPlay.1] = playingShape
       // boardButtonsCollection[buttonIndex].setImage(UIImage(named: playingShape.rawValue.capitalized), for: .normal)
        boardImageCollection[imageIndex].image = UIImage(named: playingShape.rawValue.capitalized)
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
        var playedIndex = (-1,-1)
        playedIndex.0 = (sender.tag - 1) / 3
        playedIndex.1 = (sender.tag - 1) % 3

        
        if currentBoard[playedIndex.0][playedIndex.1] == .E {
            currentBoard[playedIndex.0][playedIndex.1] = playingShape
            // boardButtonsCollection[sender.tag - 1].setImage(UIImage(named: playingShape.rawValue.capitalized), for: .normal)
            boardImageCollection[sender.tag - 1].image = UIImage(named: playingShape.rawValue.capitalized)
            switch getState(board: currentBoard, playerShape: playingShape) {
            case .PLAYING_USER_WON:
                winner = .PLAYER_1
                gameDone()
            case .TIE:
                winner = .TIE
                gameDone()
            case .INCOMPLETE:
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    self.playComputer(playingShape: .O)
                }
            }
        }
    
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
    
    func reset() {
        currentBoard = [[.E, .E, .E],[.E, .E, .E],[.E, .E, .E]]
        playingShape = .X
        winner = .NONE
        for image in boardImageCollection {
            image.image = UIImage(named: "")
        }
    }


}
