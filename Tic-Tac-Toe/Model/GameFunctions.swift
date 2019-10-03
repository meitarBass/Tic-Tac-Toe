//
//  GameFunctions.swift
//  Tic-Tac-Toe
//
//  Created by Meitar Basson on 01/10/2019.
//  Copyright © 2019 Meitar Basson. All rights reserved.
//

import Foundation

// Check board state
// E = Empty

func getState(board: [[Shape]], playerShape: Shape) -> GameState {
    
    // Check for win in a row or column
    for i in 0...2 {
        if (board[i][0] != .E && board[i][0] == board[i][1] && board[i][1] == board[i][2]) || (board[0][i] != .E && board[0][i] == board[1][i] && board[1][i] == board[2][i]) {
            return .PLAYING_USER_WON
        }
    }
    
    // Check for win in alahson
    if board[0][0] == board[1][1] && board[1][1] == board[2][2] && board[0][0] != .E || board[0][2] == board[1][1] && board[1][1] == board[2][0] && board[0][2] != .E {
        return .PLAYING_USER_WON
    }
    
    
    // Check for tie
    var countPieces = 0
    for row in board {
        for col in row {
            if col != .E {
                countPieces = countPieces + 1
            }
        }
    }
    
    if countPieces < 9 {
        return .INCOMPLETE
    }
    
    // Check for none of the above
    return .TIE
}


// MARK: Check best play

// Grade all moves
// 1 - Computer Win
// 0 - Not good or bad so pick random
// -1 - Computer Lose
// -2 - Spot taken

func checkBestPlay(board: [[Shape]], shape: Shape) -> (Int, Int) {
    
    // The chosen index
    var highIndex = (0, 0)
    
    // Timed variables
    var timeBoard = board
    var timedShape = shape
    
    // Array for storing the score of each spot
    var scoreArray = [[-2,-2,-2],[-2,-2,-2],[-2,-2,-2]]
    
    for (indexR,row) in board.enumerated() {
        for (indexC,col) in row.enumerated() {
            if col == .E {
                // Check if the computer can win
                timeBoard[indexR][indexC] = timedShape
                switch getState(board: timeBoard, playerShape: timedShape) {
                    case .PLAYING_USER_WON:
                        scoreArray[indexR][indexC] = 1
                    case .INCOMPLETE, .TIE:
                        if scoreArray[indexR][indexC] != -1 {
                            scoreArray[indexR][indexC] = 0
                        }
                }
                
                // Change shape
                if shape == .O {
                    timedShape = .X
                } else {
                    timedShape = .O
                }
                
                // Check if the opponent can win
                timeBoard[indexR][indexC] = timedShape
                switch getState(board: timeBoard, playerShape: timedShape) {
                    case .PLAYING_USER_WON:
                        if scoreArray[indexR][indexC] != 1 {
                            scoreArray[indexR][indexC] = -1
                        }
                    case .INCOMPLETE, .TIE: break
                }
                
                timedShape = shape
                timeBoard[indexR][indexC] = .E
            }
        }
       
    }
    
    // Return the chosen index for the computer's turn
    // Checking for the best index, 1 is the best, then -1 (block opponent), and least is 0, -2 = can't play
    
    // Array for generating random index
    var bestIndexArray = [(Int, Int)]()
    
    for (indexR, row) in scoreArray.enumerated() {
        for (indexC, col) in row.enumerated() {
            if col == 1 {
                highIndex = (indexR, indexC)
                return highIndex
            } else if col == -1 {
                highIndex = (indexR, indexC)
            } else if col == 0 && scoreArray[highIndex.0][highIndex.1] != -1 {
                highIndex = (indexR, indexC)
                bestIndexArray.append(highIndex)
                // generating random index to be picked
                let randomIndex = Int.random(in: 0..<bestIndexArray.count)
                highIndex = bestIndexArray[randomIndex]
            }
        }
    }
    
    return highIndex
}
