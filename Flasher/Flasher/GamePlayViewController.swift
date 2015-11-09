//
//  GamePlayViewController.swift
//  Flasher
//
//  Created by Anjel Villafranco on 11/5/15.
//  Copyright © 2015 Anjel Villafranco. All rights reserved.
//

import UIKit


class GamePlayViewController: UIViewController, UITextFieldDelegate {
    
    
    
    @IBOutlet weak var countdownLabel: UILabel!
    
    @IBOutlet weak var questionView: UILabel!
    
    @IBOutlet weak var answerField: UITextField!

    
    
    var timer = NSTimer()
    
    var count = 60{
        didSet {
            countdownLabel.text = String(count)
        }
    }
    
    
    
    
    var cardsData: [[String:AnyObject]] = []
    
    var currentCard = 0
    
    func loadCard() {
        
        questionView.text = cardsData[currentCard]["question"] as? String
        
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        let answer = cardsData[currentCard]["answer"] as! String
        if let guess = answerField.text {
            
            if guess == answer {
                
                answerField.text = nil
                currentCard++
                loadCard()
            }
        }
        return true
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
      
    }
    
    override func  viewDidLoad() {
        super.viewDidLoad()
       
       timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "updateTimer", userInfo: nil, repeats: true)
        
        

        
        answerField.delegate = self
        
        var info = RequestInfo()
        
        //        info.endpoint = "/cards"
        //        info.method = .GET
        
        info.endpoint = "/decks/\(selectedDeckId)/cards"
        info.method = .GET
        
        RailsRequest.session().requestWithInfo(info) { (returnedInfo) -> () in
            
            print(returnedInfo)
            
            if let cards = returnedInfo?["cards"] as? [[String:AnyObject]] {
                
                self.cardsData = cards
                print(cards)
                self.loadCard()
                
            }
        }
    }
    
    
    
    //MARK: TIMER FUNCTION
    
    func updateTimer() {
        
        print("Timer fired")
        
        if count <= 1 {
            timer.invalidate()
            print("game over")
        }
        count--
        print("Current count is : \(count)")
    }
    
}


