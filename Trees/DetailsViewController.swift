//
//  DetailsViewController.swift
//  Trees
//
//  Created by John Linnane on 07/03/2019.
//  Copyright © 2019 UCC. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var latinNameLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var loreLabel: UILabel!
    
    @IBAction func webInfoAction(_ sender: UIButton) {
    }
    

    var speciesData : TreesCoreDataModel!
    
    
    override func viewDidLoad() {

        super.viewDidLoad()
        
        // call the background class and function
        let background = SetBackground(view: view, backgroundImage: "Images/treeBackground.jpg")
        background.setBackground()
        
        // Do any additional setup after loading the view.
        self.title = "Species Details"
        
        //personData is pushed from screen one
        
        //populate outlets with data
        nameLabel.text      = speciesData.name
        latinNameLabel.text = speciesData.latinName
        heightLabel.text    = speciesData.height
        originLabel.text    = speciesData.origin
        loreLabel.text      = speciesData.lore
        
    }
    

    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Get the new view controller using segue.destination.
        let destination = segue.destination as! WebViewController
        
        // Pass the selected object to the new view controller.
        destination.urlData = self.speciesData.url

    }
    
    
} // end DetailsViewController class

