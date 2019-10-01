//
//  GameFunctions.swift
//  Tic-Tac-Toe
//
//  Created by Meitar Basson on 01/10/2019.
//  Copyright © 2019 Meitar Basson. All rights reserved.
//

import Foundation

// Check board state
// Get board (2 dimension array)
// return 1 of 4 option: (enum)
// Incomplete - 3
// Player 1 won - 1
// Player 2 won - 2
// Tie - 4

func getResult(board: [[String]]) -> Int {
    for i in 0...2 {
        if (board[i][0] != "" && board[i][0] == board[i][1] && board[i][1] == board[i][2]) || board[0][i] != "" && board[0][i] == board[1][i] && board[1][i] == board[2][i] {
            let playerTurn = checkWhoseTurn()
            switch playerTurn {
                // Covered all the options, need to use enum instead of Int
                case 1:
                    return 1
                case 2:
                    return 2
            default:
                return 0
            }
        }
    }
    
    var countPieces = 0
    for row in board {
        for col in row {
            if col != "" {
                countPieces = countPieces + 1
            }
        }
    }
    
    if countPieces < 9 {
        return 3
    }
    return 4
}

func checkWhoseTurn() -> Int {
    return 1
}


// Check best play
// Grade all moves
// 1 - You Win
// 0 - Not good or bad so pick random
// -1 - You Lose

func checkBestPlay() {
    
}



