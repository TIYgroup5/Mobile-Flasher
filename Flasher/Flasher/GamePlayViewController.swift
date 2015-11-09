//
//  GamePlayViewController.swift
//  Flasher
//
//  Created by Anjel Villafranco on 11/5/15.
//  Copyright © 2015 Anjel Villafranco. All rights reserved.
//

import UIKit

//var selectedDeckId: String = ""

class GamePlayViewController: UIViewController {

    @IBOutlet weak var countdownLabel: UILabel!
    
    @IBOutlet weak var questionView: UILabel!
    
    @IBOutlet weak var answerField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        var info = RequestInfo()
        
//        info.endpoint = "/cards"
//        info.method = .GET
        
        info.endpoint = "/decks/\(selectedDeckId)/cards"
        info.method = .GET
        
        RailsRequest.session().requestWithInfo(info) { (returnedInfo) -> () in
            
            print(returnedInfo)
            
            if let card = returnedInfo?["cards"] as? [[String:AnyObject]] {
                
                print(card)
                
            }
            
            if let id = returnedInfo?["id"] as? [[String:AnyObject]] {
                
                print(id)
            }
            // reload picker
            
        }

    func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    }
}
