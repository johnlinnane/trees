//
//  TreeList.swift
//  Trees
//
//  Created by John Linnane on 12/02/2019.
//  Copyright © 2019 UCC. All rights reserved.
//

import Foundation

// create a class to receive parsed data from XML file
class TreeList {
    
    var treesData : [Species]
    
    init() {
        treesData =
        [
                
            Species(name: "Mr Tree", latinName: "Treeus Maximus", height: "12345678m", origin: "ALASKA", lore : "Killed own father.", image: "ash.jpg", url: "https://www.treezone.ie")
        ]
    }
    
    init(fromContentOfXML : String){
        // make a XMLDogParser
        let parser = XMLTreesParser(name: fromContentOfXML)
        
        // parsing
        parser.parsing()
        
        // set peopleData with what comes from parsing
        treesData = parser.treeList
    }
    
    
    func count()-> Int {return treesData.count}
    func speciesData(index:Int)->Species {return treesData[index]}
    
} // end TreeList class
