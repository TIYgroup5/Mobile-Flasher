//
//  ViewController.swift
//  Flasher
//
//  Created by Anjel Villafranco on 11/4/15.
//  Copyright © 2015 Anjel Villafranco. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func deckData() {
        
        var info = RequestInfo()
        
        info.endpoint = "/decks"
        info.method = .GET
        
        RailsRequest.session().requestWithInfo(info) { (returnedInfo) -> () in
        
            // set picker array = returnedInfo["deck"]
            // reload picker
            
        }
    
    }


}


