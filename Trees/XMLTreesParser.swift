//
//  XMLTreesParser.swift
//  Trees
//
//  Created by John Linnane on 07/03/2019.
//  Copyright © 2019 UCC. All rights reserved.
//

import Foundation

// create a class to parse XML data, using built-in XMLParser class
class XMLTreesParser : NSObject, XMLParserDelegate{
    
    var name:String
    init(name:String){self.name = name}
    
    //variables to hold tag data
    var pName, pLatinName, pHeight , pOrigin, pLore, pImage, pUrl :String!
    
    //var to spy during parsing
    var elementID = -1
    var passData = false
    
    //vars to manage whole data
    var species = Species()
    var treeList = [Species]()
    var parser : XMLParser!
    var tags = ["name", "latinName", "height", "origin", "lore", "image", "url"]
    
    //parser delegate methods
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        //based on the spies grab some data into pVars
        // create variables for parsed data
        if passData{
            switch elementID{
                case 0 : pName = string
                case 1 : pLatinName = string
                case 2 : pHeight = string
                case 3 : pOrigin = string
                case 4 : pLore = string
                case 5 : pImage = string
                case 6 : pUrl = string
                default: break
                
            }
        }
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        // if element name is in tags then spy
        
        if tags.contains(elementName){
            passData = true
            
            switch elementName{
                case "name"      : elementID = 0
                case "latinName" : elementID = 1
                case "height"    : elementID = 2
                case "origin"    : elementID = 3
                case "lore"      : elementID = 4
                case "image"     : elementID = 5
                case "url"       : elementID = 6
                default          :break
                
            }
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        //reset the spys
        if tags.contains(elementName){
            passData = false
            elementID = -1
        }
        
        //if elementName is species then make a species and append to trees
        if elementName == "species"{
            species = Species(name: pName, latinName: pLatinName, height: pHeight, origin: pOrigin, lore: pLore, image: pImage, url: pUrl)
            treeList.append(species)
        }
    }
    
    
    
    func parsing(){
        // get the path of the xml file
        let bundleUrl = Bundle.main.bundleURL
        let fileUrl = URL(string: self.name, relativeTo: bundleUrl)
        
        //make a parser for thos file
        parser = XMLParser(contentsOf: fileUrl!)!
        
        parser.delegate = self
        parser.parse()
    }
} // end XMLTreesParser class

