//
//  GameController.swift
//  Tic-Tac-Toe
//
//  Created by Meitar Basson on 01/10/2019.
//  Copyright © 2019 Meitar Basson. All rights reserved.
//

import UIKit

class GameController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
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
