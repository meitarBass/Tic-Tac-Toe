//
//  GameOverController.swift
//  Tic-Tac-Toe
//
//  Created by Meitar Basson on 01/10/2019.
//  Copyright © 2019 Meitar Basson. All rights reserved.
//

import UIKit

class GameOverController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var winnerImage: UIImageView!
    @IBOutlet weak var winnerLabel: UILabel!
    
    // MARK: Variables
    var winner: WINNER!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let wUser = winner {
            switch wUser {
                case .PLAYER_1:
                    winnerLabel.text = "Player 1 wins"
                    winnerImage.image = UIImage(named: "man-user-blue")
                case .PLAYER_2:
                    winnerLabel.text = "Computer wins"
                    winnerImage.image = UIImage(named: "man-user-red")
                case .TIE:
                    winnerLabel.text = "Tie"
                    winnerImage.image = UIImage(named: "draw-icon")
                default: break
            }
        }
    }
    
    // MARK: Actions
    
    @IBAction func playAgainButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: {})
    }
    
    // MARK: Home button works with unwindSegue
}
