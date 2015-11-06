//
//  GamePlayViewController.swift
//  Flasher
//
//  Created by Anjel Villafranco on 11/5/15.
//  Copyright © 2015 Anjel Villafranco. All rights reserved.
//

import UIKit

class GamePlayViewController: UIViewController {

    @IBOutlet weak var questionView: UILabel!
    
    @IBOutlet weak var answerField: UITextField!
    
    @IBAction func submitAnswer(sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
