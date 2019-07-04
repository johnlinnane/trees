//
//  Species.swift
//  Trees
//
//  Created by John Linnane on 07/03/2019.
//  Copyright © 2019 UCC. All rights reserved.
//

import Foundation

// create a class to initialise all variable for getting information from XML file
class Species
{
    //properties
    var name      : String
    var latinName : String
    var height    : String
    var origin    : String
    var lore      : String
    var image     : String
    var url       : String
    
    //initialisers
    init() {
        
        self.name = "Mr Tree"
        self.latinName = "no latin name"
        self.height = "none"
        self.origin = "none"
        self.lore = "none"
        self.image = "none"
        self.url = "none"
    }
    
    init(name:String, latinName:String, height:String, origin:String, lore:String, image:String, url:String) {
        
        self.name = name
        self.latinName = latinName
        self.height = height
        self.origin = origin
        self.lore = lore
        self.image = image
        self.url = url
    }
    
    //methods
    func setName(name:String){self.name = name}
    func getName()->String{return self.name}
    
    
    func setLatinName(latinName:String){self.latinName = latinName}
    func getLatinName()->String{return self.latinName}
    
    
    func setHeight(height:String){self.height = height}
    func getHeight()->String{return self.height}
    
    
    func setOrigin(origin:String){self.origin = origin}
    func getOrigin()->String{return self.origin}
    
    
    func setLore(lore:String){self.lore = lore}
    func getLore()->String{return self.lore}
    
    
    func setImage(image:String){self.image = image}
    func getImage()->String{return self.image}
    
    
    func setUrl(url:String){self.url = url}
    func getUrl()->String{return self.url}
} // end Species class

