//
//  Cell.swift
//  Sample-Swift_instagram
//
//  Created by RYPE on 14/05/2015.
//  Copyright (c) 2015 weareopensource. All rights reserved.
//

import UIKit

class Cell: UICollectionViewCell {
    
    
    /*************************************************/
     // Main
     /*************************************************/
     
     // Boulet
     /*************************/
    
    @IBOutlet weak var myImageAuthorView: UIImageView!
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var myLabelAuthor: UILabel!
    @IBOutlet weak var myLabelRight: UILabel!

    
    
    // Base
    /*************************/
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    /*
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if(selected) {
            myView.backgroundColor = UIColor(netHex: GlobalConstants.BackgroundColorTableViewDetailView).colorWithAlphaComponent(0.5)
        }
    }
    
    override func setHighlighted(highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        
        if(highlighted) {
            myView.backgroundColor = UIColor(netHex: GlobalConstants.BackgroundColorTableViewDetailView).colorWithAlphaComponent(0.5)
        }
    }*/
    
}
