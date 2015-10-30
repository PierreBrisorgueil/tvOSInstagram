//
//  ApiController.swift
//  Benestar
//
//  Created by RYPE on 21/05/2015.
//  Copyright (c) 2015 Yourcreation. All rights reserved.
//

import Foundation


/**************************************************************************************************/
 // Protocol
 /**************************************************************************************************/
protocol APIControllerProtocol {
    func didReceiveAPIResults(results: NSArray)
}

/**************************************************************************************************/
 // Class
 /**************************************************************************************************/
class APIController {
    
    /*************************************************/
     // Main
     /*************************************************/
     
     // Var
     /*************************/
    var delegate: APIControllerProtocol
    
    // init
    /*************************/
    init(delegate: APIControllerProtocol) {
        self.delegate = delegate
    }
    
    /*************************************************/
     // Functions
     /*************************************************/
    func get(path: String) {
        let url = NSURL(string: path)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!, completionHandler: {data, response, error -> Void in
            print("Task completed")
            if(error != nil) {
                // If there is an error in the web request, print it to the console
                print(error!.localizedDescription)
            }
            do {
                let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                //print(jsonResult["data"])
                if let results = jsonResult["data"] as? NSArray {
                    self.delegate.didReceiveAPIResults(results)
                }
            } catch let error as NSError {
                print(error.description)
            }
        })
        task.resume()
    }
    
    func instagram() {
        get("https://api.instagram.com/v1/users/\(GlobalConstants.TwitterInstaUserId)/media/recent/?access_token=\(GlobalConstants.TwitterInstaAccessToken)")
    }

}

