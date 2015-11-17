//
//  DeckViewController.swift
//  Flasher
//
//  Created by Anjel Villafranco on 11/5/15.
//  Copyright © 2015 Anjel Villafranco. All rights reserved.
//

import UIKit

var selectedDeckId: Int = 0

class DeckViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate
    {
    
    @IBOutlet weak var chooseDeck: UIButton!
    
    @IBOutlet weak var textLabel: UILabel!
    
    @IBOutlet weak var findDeck: UIPickerView!
    
    @IBAction func timerModeSwitch(sender: AnyObject) {
    }
    
    var pickerData: [[String:AnyObject]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        findDeck.dataSource = self
        findDeck.delegate = self
        
        var info = RequestInfo()
        
        info.endpoint = "/decks"
        info.method = .GET
        
        RailsRequest.session().requestWithInfo(info) { (returnedInfo) -> () in
            
            print(returnedInfo)
            
            if let decks = returnedInfo?["decks"] as? [[String:AnyObject]] {
                
                self.pickerData = decks
                self.findDeck.reloadAllComponents()
                
            }
            
            if let id = returnedInfo?["id"] as? [[String:AnyObject]] {
                
                self.pickerData = id
                self.findDeck.reloadAllComponents()
                
            }
        }
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
       
        var pickerLabel = view as! UILabel!
        
        if view == nil {  //if no label there yet
            pickerLabel = UILabel()
            
        }
        
        let titleData = pickerData[row]["title"] as! String
       
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "PermanentMarker", size: 26.0)!,NSForegroundColorAttributeName:UIColor.whiteColor()])
       
        pickerLabel!.attributedText = myTitle
        pickerLabel!.textAlignment = .Center
        
        return pickerLabel
        
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        textLabel.text = pickerData[row]["title"] as? String
        selectedDeckId = (pickerData[row]["id"] as? Int)! 
        
    }
}

    
        
