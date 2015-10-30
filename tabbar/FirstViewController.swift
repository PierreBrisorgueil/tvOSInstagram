//
//  FirstViewController.swift
//  tabbar
//
//  Created by RYPE on 25/10/15.
//  Copyright © 2015 Yourcreation. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, APIControllerProtocol {

    
    /*************************************************/
    // Main
    /*************************************************/
     
    // Var
    /*************************/
    var posts = [Post]()
    var imageCache = [String:UIImage]()
    var api : APIController!
    
    // Boulet
    /*************************/
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var myView: UIView!

    
    // Base
    /*************************/
    override func viewDidLoad() {
        super.viewDidLoad()
        
        api = APIController(delegate: self)
        api.instagram()
        
        collectionView.backgroundColor = UIColor(netHex: GlobalConstants.BackgroundColor)
        myView.backgroundColor = UIColor(netHex: GlobalConstants.BackgroundColor)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    // CollectionView
    /*************************/
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return posts.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! Cell
        let post = posts[indexPath.row]
            
        cell.myLabelAuthor.text = String(post.authorName)
        cell.myImageView?.image = UIImage(named: "picture")
        cell.myImageAuthorView?.image = UIImage(named: "picture")
        cell.myLabelRight.text = String(post.comments) +  " ✍ " +  String(post.likes) + " ♥︎"
        
        let imgURLStringAuthor = post.authorImg
        let imgURLAuthor = NSURL(string: imgURLStringAuthor)!
        
        let imgURLString = post.img
        let imgURL = NSURL(string: imgURLString)!

        if let imgAuthor = imageCache[imgURLStringAuthor] {
            cell.myImageAuthorView.image = imgAuthor
        }
        else {
            let session = NSURLSession.sharedSession()
            let request = NSURLRequest(URL: imgURLAuthor)
            let dataTask = session.dataTaskWithRequest(request) { (data:NSData?, response:NSURLResponse?, error:NSError?) -> Void in
                if error == nil {
                    let image = UIImage(data: data!)
                    self.imageCache[imgURLStringAuthor] = image
                    dispatch_async(dispatch_get_main_queue(), {
                        
                        if let cellToUpdate = collectionView.cellForItemAtIndexPath(indexPath) as? Cell {
                            cellToUpdate.myImageAuthorView.image = image
                            // animation
                            // ---------------------
                            cellToUpdate.myImageAuthorView?.alpha = 0
                            UIView.animateWithDuration(0.5, delay: 0,
                                options: [], animations: {
                                    cellToUpdate.myImageAuthorView?.alpha = 1
                                }, completion: nil)
                            // ---------------------
                        }
                    })
                }
                else {
                    print("Error: \(error!.localizedDescription)")
                }
            }
            dataTask.resume()
        }
        
        
        if let img = imageCache[imgURLString] {
            cell.myImageView.image = img
        }
        else {
            let session = NSURLSession.sharedSession()
            let request = NSURLRequest(URL: imgURL)
            let dataTask = session.dataTaskWithRequest(request) { (data:NSData?, response:NSURLResponse?, error:NSError?) -> Void in
                if error == nil {
                    let image = UIImage(data: data!)
                    self.imageCache[imgURLString] = image
                    dispatch_async(dispatch_get_main_queue(), {
                        if let cellToUpdate = collectionView.cellForItemAtIndexPath(indexPath) as? Cell {
                            cellToUpdate.myImageView.image = image
                            // animation
                            // ---------------------
                            cellToUpdate.myImageView?.alpha = 0
                            UIView.animateWithDuration(0.5, delay: 0,
                                options: [], animations: {
                                    cellToUpdate.myImageView?.alpha = 1
                                }, completion: nil)
                            // ---------------------
                        }
                    })
                }
                else {
                    print("Error: \(error!.localizedDescription)")
                }
            }
            dataTask.resume()
        }
        
        // Custom
        // ---------------------
        cell.backgroundColor = UIColor(netHex: GlobalConstants.BackgroundColor2)
        cell.layer.cornerRadius = 6
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor(netHex: GlobalConstants.BorderColor).CGColor
        let path = UIBezierPath(roundedRect:cell.layer.bounds, byRoundingCorners:[UIRectCorner.BottomRight, .BottomLeft], cornerRadii: CGSizeMake(6, 6))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.CGPath
        cell.layer.mask = maskLayer
        cell.myImageAuthorView.layer.cornerRadius = cell.myImageAuthorView.frame.size.width / 2
        cell.myImageAuthorView.clipsToBounds = true
        cell.myImageAuthorView.layer.borderColor = UIColor(netHex: GlobalConstants.BorderColor).CGColor
        // ---------------------
        
        return cell
    }
    
    

    /*************************************************/
     // Functions
     /*************************************************/
     
     // Other
     /*************************/
    func didReceiveAPIResults(results: NSArray) {
        dispatch_async(dispatch_get_main_queue(), {
            self.posts = Post.postsWithJSON(results)
            self.collectionView.reloadData()
        })
    }
    
}

