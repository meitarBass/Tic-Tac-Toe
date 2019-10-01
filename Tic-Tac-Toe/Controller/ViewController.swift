//
//  ViewController.swift
//  Tic-Tac-Toe
//
//  Created by Meitar Basson on 30/09/2019.
//  Copyright © 2019 Meitar Basson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func creditsButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "ToCredits", sender: nil)
    }
    
    @IBAction func playButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "ToGame", sender: nil)
    }
    
    @IBAction func unwindToRoot(_ unwindSegue: UIStoryboardSegue) {}
    
}

