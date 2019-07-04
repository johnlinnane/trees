//
//  SetBackground.swift
//  Trees
//
//  Created by John Linnane on 08/03/2019.
//  Copyright © 2019 UCC. All rights reserved.
//

import Foundation
import UIKit


// create a background class
class SetBackground {
    var view: UIView!
    let backgroundImageView = UIImageView()
    var backgroundImage: UIImage
    
    
    // create default UI Image
    init(view: UIView) {
        self.view = view
        self.backgroundImage = UIImage.init()
    }
    
    // create UI image with image location as parameter
    init(view: UIView, backgroundImage: String) {
        self.view = view
        self.backgroundImage = UIImage(named: backgroundImage)!
    }
    
    // create the image function
    
    func setBackground() {
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        backgroundImageView.image = backgroundImage
        view.sendSubviewToBack(backgroundImageView)
    }
} // end SetBackground class
