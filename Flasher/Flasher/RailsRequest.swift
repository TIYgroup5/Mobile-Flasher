//
//  RailsRequest.swift
//  RR
//
//  Created by Susanne Burnham on 11/5/15.
//  Copyright © 2015 Susanne Kasahara. All rights reserved.
//

// making a singleton to access a token

import UIKit

private let _rr = RailsRequest()

private let _d = NSUserDefaults.standardUserDefaults()

class RailsRequest: NSObject {
    

    
    class func session() -> RailsRequest { return _rr }
    
    var token: String? {
        
        get { return _d.objectForKey("token") as? String }
        set { _d.setObject(newValue, forKey: "token") }
    
    
    }
    
    //// CHANGE OUT WITH TEAM 5
    /// need methods and parameters for request, endpoint type and parameters
    
    
    private let base = "https://rocky-garden-9800.herokuapp.com"
    
    func loginWithUsername(username: String, andPassword password: String) {
        var info = RequestInfo()
        
      info.endpoint = "/users/login"
        info.method = .POST
        info.parameters = [
        
            "username" : username,
//            "full_name" : fullname,
            "password" : password
        
    ]
        
        requestWithInfo(info) { (returnedInfo) -> () in
            
            // here we grab the access token & user id in cards table view controller ,
            
            if let user = returnedInfo?["user"] as? [String:AnyObject] {
                
                if let key = user["access_Key"] as? String {
                    
                    self.token = key
                    
                    print(self.token)
                }
            }
            
            
            
        }
    
    }
    
    // info:AnyObhect may not be the info need to casr (info: ANyObject cast for
    func requestWithInfo(info: RequestInfo, completion: (returnedInfo: AnyObject?) -> ()) {
        
        let fullURLString = base + info.endpoint
    
        guard let url = NSURL(string: fullURLString) else { return } // add run completion with fail
        
        let request = NSMutableURLRequest(URL: url)
        
        request.HTTPMethod = info.method.rawValue
        
        //add token if we have one
        
        if let token = token {
            
            // can add token when they give it to you
            request.setValue(token, forHTTPHeaderField: "auth_token")
        }
        
        // add parameters to body 1. checked info parameters, turns to request data and set value for headerfield JSON string remove post data and pass in request data if weird characters show up
        
        if let requestData = try? NSJSONSerialization.dataWithJSONObject(info.parameters, options: .PrettyPrinted) {
            
            if let jsonString = NSString(data: requestData, encoding: NSUTF8StringEncoding) {
                    
                    request.setValue("\(jsonString.length)", forHTTPHeaderField: "Content-Length")
                    
                    let postData = jsonString.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: true)
                    
                    request.HTTPBody = postData

                    
            }
            
        }
        
        // creates a task from request - based on network connectivity
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
            
            
            
            // work with data returned
            
            if let data = data {
                
                // have data
                
                if let returnedInfo = try? NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) {
                    
                    completion(returnedInfo: returnedInfo)
                    
                }
                
            } else {
                
                // no data: check for error and return alert from
            }
            }
        task.resume()
        
        
    }


struct RequestInfo {
    
    enum MethodType: String {
    
            case POST, GET, DELETE
    }
    
    var endpoint: String!
    var method: MethodType = .GET
    var parameters: [String:AnyObject] = [:]
}

}
