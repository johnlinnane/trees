//
//  SpeciesViewController.swift
//  Trees
//
//  Created by John Linnane on 07/03/2019.
//  Copyright © 2019 UCC. All rights reserved.
//

import UIKit

class SpeciesViewController: UIViewController {
    
    // outlet and actions
    @IBOutlet weak var speciesImageView: UIImageView!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBAction func moreInfoAction(_ sender: Any) {
    }
    
    @IBAction func add(_ sender: Any) {
    }
    
    var speciesData : TreesCoreDataModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Selected Tree"
        
        // call the background class and function
        let background = SetBackground(view: view, backgroundImage: "Images/treeBackground.jpg")
        background.setBackground()
        

        // Do any additional setup after loading the view.
        
        //populate the outlet with data
        speciesLabel.text = speciesData.name
        if speciesData.image != nil {
            speciesImageView.image = UIImage(named: speciesData.image!)
        }
        
    }
    
    
    func getImage(name:String){
        // get file manager
        let fm = FileManager.default
        // find path to Documents
        let docPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
        //append name to path
        let path = docPath.appendingPathComponent(name)
        
        //grab image data
        if fm.fileExists(atPath: path) {
            speciesImageView.image = UIImage(contentsOfFile: path)
        } else {
            print("FILE DOES NOT EXIST")
        }
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        let destinationController = segue.destination as! DetailsViewController
        
        // Pass the selected object to the new view controller.
        destinationController.speciesData = speciesData
    }
    
    
} // end SpeciesViewController class
