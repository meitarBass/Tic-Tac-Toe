//
//  GameController.swift
//  Tic-Tac-Toe
//
//  Created by Meitar Basson on 01/10/2019.
//  Copyright © 2019 Meitar Basson. All rights reserved.
//

import UIKit

class GameController: UIViewController {
    
    // @IBOutlet var boardButtonsCollection: [UIButton]!
    
    // MARK: Outlets
    @IBOutlet var buttonsCollection: [UIButton]!
    @IBOutlet var boardImageCollection: [UIImageView]!
    @IBOutlet weak var leftIndicator: CustomView!
    @IBOutlet weak var rightIndicator: CustomView!
    
    // MARK: Variables
    var currentBoard: [[Shape]] = [[.E, .E, .E],[.E, .E, .E],[.E, .E, .E]]
    var playingShape: Shape = .X // Player 1 turn
    var winner: WINNER = .NONE
    var alert: UIAlertController!
    
    // Undo Last Move
    var lastMove: [(Int, Int)] = [(Int, Int)]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Build alert
        alert = UIAlertController(title: "", message: "Are you sure you want to undo?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { _ in
            self.undoLastMove()
        }))
    }
    
    // MARK: Actions
    
    // Segues and transition between controllers
    @IBAction func ExitButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: {})
    }
    
    // Undo button, need to change functionallity
    @IBAction func UndoButtonTapped(_ sender: UIButton) {
        // act like game done for now
        if lastMove.count > 1 {
            self.present(alert, animated: true)
        }
    }
    
    @IBAction func boardTapped(_ sender: UIButton) {
        var playedIndex = (-1,-1)
        playedIndex.0 = (sender.tag - 1) / 3
        playedIndex.1 = (sender.tag - 1) % 3

        if currentBoard[playedIndex.0][playedIndex.1] == .E {
            currentBoard[playedIndex.0][playedIndex.1] = playingShape
            boardImageCollection[sender.tag - 1].image = UIImage(named: playingShape.rawValue.capitalized)
            
            lastMove.append((playedIndex.0, playedIndex.1))
            
            leftIndicator.layer.shadowOpacity = 0.0
            rightIndicator.layer.shadowOpacity = 0.9
            switch getState(board: currentBoard, playerShape: playingShape) {
            case .PLAYING_USER_WON:
                winner = .PLAYER_1
                gameDone()
            case .TIE:
                winner = .TIE
                gameDone()
            case .INCOMPLETE:
                disableEnableButtons()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                    self.playComputer(playingShape: .O)
                    self.leftIndicator.layer.shadowOpacity = 0.9
                    self.rightIndicator.layer.shadowOpacity = 0.0
                    self.disableEnableButtons()
                }
            }
        }
    
    }
    
    // MARK: Computer Play
    
    func playComputer(playingShape: Shape) {
        let bestPlay = checkBestPlay(board: currentBoard, shape: playingShape)
        let imageIndex = bestPlay.0 * 3 + bestPlay.1
        
        // Repeating this part in the player play also, need to make it a function
        currentBoard[bestPlay.0][bestPlay.1] = playingShape
        boardImageCollection[imageIndex].image = UIImage(named: playingShape.rawValue.capitalized)
        lastMove.append((bestPlay.0, bestPlay.1))
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
    
    // MARK: Undo function
    
    func undoLastMove() {
        if lastMove.count > 1 {
            for _ in 0..<2 {
                let move = lastMove.last!
                let imageIndex = move.0 * 3 + move.1
                currentBoard[move.0][move.1] = .E
                boardImageCollection[imageIndex].image = UIImage(named: "")
                playingShape = .X
                lastMove.removeLast()
            }
        }
    }
    
    // MARK: Disable or Enable button
    // Disable on computer's turn
    // Enable on user's turn
    
    func disableEnableButtons() {
        for eachBtn in buttonsCollection {
            eachBtn.isEnabled = !eachBtn.isEnabled
        }
    }
    
    // MARK: Game done functions
    
    func gameDone() {
        performSegue(withIdentifier: "ToGameOver", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Detect who won
        self.reset()
        if segue.destination is GameOverController {
            alert.dismiss(animated: true, completion: {})
            let gameOverController = segue.destination as? GameOverController
            gameOverController?.winner = winner
        }
        
    }
    
    func reset() {
        currentBoard = [[.E, .E, .E],[.E, .E, .E],[.E, .E, .E]]
        playingShape = .X
        winner = .NONE
        leftIndicator.layer.shadowOpacity = 0.9
        rightIndicator.layer.shadowOpacity = 0.0
        for image in boardImageCollection {
            image.image = UIImage(named: "")
        }
    }

}
