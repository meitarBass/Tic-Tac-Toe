//
//  enums.swift
//  Tic-Tac-Toe
//
//  Created by Meitar Basson on 01/10/2019.
//  Copyright © 2019 Meitar Basson. All rights reserved.
//

import Foundation

enum GameState: Int {
    case PLAYING_USER_WON = 1
    case INCOMPLETE = 2
    case TIE = 3
}

enum Shape: String {
    case X = "x"
    case O = "o"
    case E = ""
}

enum WINNER: Int {
    case PLAYER_1 = 1
    case PLAYER_2 = 2
    case TIE = 3
}
