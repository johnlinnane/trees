//
//  TreesTableViewController.swift
//  Trees
//
//  Created by John Linnane on 11/03/2019.
//  Copyright © 2019 John Linnane. All rights reserved.
//

import UIKit
import CoreData


class TreesTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    // core data objects, entity, managedObject and frc (fetch results controller)
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var entity : NSEntityDescription! = nil
    var treesListManagedObject : TreesCoreDataModel! = nil
    var frc : NSFetchedResultsController<NSFetchRequestResult>! = nil      // <> contains data type
    var treesData : TreeList!
    
    
    
    
    // need to make a request. what to filter and sort
    func makeRequest()->NSFetchRequest<NSFetchRequestResult>{
        
        // make a request for TreesCoreDataModel entity
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "TreesCoreDataModel")
        
        // describe how to sort and how to filter it
        let sorter = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [sorter]
        
        // filter all the items with name sabin. %K defines attribute. %@ refers to the value.
        //let predicate = NSPredicate(format: "%K == %@", "name", "sabin")
        //request.predicate = predicate
        
        return request
        
    } // end makeRequest
    
    
    
    
    // create a function to create a managed object for each item parsed from XML file
    func fromXMLToCoreData() {
        treesData = TreeList(fromContentOfXML: "trees.xml")
        
        for i in 0..<treesData.count(){
            
            treesListManagedObject = TreesCoreDataModel(context: context)
            
            //fill with data from textfields
            treesListManagedObject.name      = treesData.treesData[i].name
            treesListManagedObject.latinName = treesData.treesData[i].latinName
            treesListManagedObject.height    = treesData.treesData[i].height
            treesListManagedObject.origin    = treesData.treesData[i].origin
            treesListManagedObject.lore      = treesData.treesData[i].lore
            treesListManagedObject.image     = treesData.treesData[i].image
            treesListManagedObject.url       = treesData.treesData[i].url
            
            //save
            do{
                try context.save()
            }catch{
                print("Core Data error")
            }
        }
    } // end func fromXMLToCoredata

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Trees Table"
        
        // make frc (fetched results controller) and fetch
        frc = NSFetchedResultsController(fetchRequest: makeRequest(), managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        frc.delegate = self
        
        // add icon to nav bar
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "AppIcon")
        imageView.image = image
        navigationItem.titleView = imageView
        
        
        // set background
        tableView.backgroundView = UIImageView(image: UIImage(named: "Images/treeBackground.jpg"))
        
        do{ try frc.performFetch()}
        catch{print("FETCH DOES NOT WORK")}
        
        // populate table with managed objected created by parsing XML file data
        if frc.sections![0].numberOfObjects == 0 {
            fromXMLToCoreData()
        }
        
    } // end viewDidLoad
    
    

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        if frc.sections![0].numberOfObjects == 0 {
            fromXMLToCoreData()
        }
        tableView.reloadData()
    }
    
    
    
    // populate list with image
    func getImage(name:String)->UIImage{
        // get file manager
        let fm = FileManager.default
        // find path to Documents
        let docPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
        //append name to path
        let path = docPath.appendingPathComponent(name)
        
        //grab image data
        if fm.fileExists(atPath: path) && name != "" {
            return UIImage(contentsOfFile: path)!
        }
        else {
            print("FILE DOES NOT EXIST")
            return UIImage(named: "acacia.jpg")!
        }
    }

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return frc.sections![section].numberOfObjects
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // make background of cells transparent
        cell.backgroundColor = UIColor.clear

        
        // get from frc the object at indexPath
        treesListManagedObject = (frc.object(at: indexPath) as! TreesCoreDataModel)
        

        // Configure the cell...
        cell.textLabel?.text = treesListManagedObject.name
        cell.detailTextLabel?.text = treesListManagedObject.latinName
        if (treesListManagedObject.image?.contains(".jpg"))! {
            cell.imageView?.image = UIImage(named: treesListManagedObject.image!)
        } else {
            cell.imageView?.image = getImage(name: treesListManagedObject.image!)
        }
        return cell
    } // end tableView func


    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // add animated table load
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewDidLoad()
        animateTable()
    }

    // define animated load function
    func animateTable() {
        tableView.reloadData()
        let cells = tableView.visibleCells

        let tableViewHeight = tableView.bounds.size.height

        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
        }

        var delayCounter = 0
        for cell in cells {
            UIView.animate(withDuration: 0.5, delay: Double(delayCounter) * 0.5, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 1
        }
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            // get the object to remove and delete it
            treesListManagedObject = frc.object(at: indexPath) as? TreesCoreDataModel
            context.delete(treesListManagedObject)
            // save the context
            do{try context.save()}
            catch{}
            // perform fetch and reload\
            do{try frc.performFetch()}
            catch{}
            
            
            tableView.reloadData()
            
        }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        if segue.identifier == "tableSegue"{
            
            
            // connect segue to Species View Controller
            let destination = segue.destination as! SpeciesViewController
            
            // Pass the selected object to the new view controller.
            let indexPath = tableView.indexPath(for: sender as! UITableViewCell)
            treesListManagedObject = (frc.object(at: indexPath!) as! TreesCoreDataModel)
            
            destination.speciesData = treesListManagedObject
        } // end if
    } // end prepare func

     
} // end class TreesTableViewController

