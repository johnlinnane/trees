//
//  AddViewController.swift
//  Trees
//
//  Created by John Linnane on 11/03/2019.
//  Copyright © 2019 John Linnane. All rights reserved.
//

import UIKit
import CoreData


class AddViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // code data objects context, entity and managedObjects
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var entity : NSEntityDescription! = nil
    var treesListManagedObject : TreesCoreDataModel! = nil
    
    
    func save(){ // save a new managed object
        
        // make a new managed object
        entity = NSEntityDescription.entity(forEntityName: "TreesCoreDataModel", in: context)
        treesListManagedObject = TreesCoreDataModel(context: context)
        
        // fill with data from textfields
        treesListManagedObject.name      = nameTextField.text
        treesListManagedObject.latinName = latinNameTextField.text
        treesListManagedObject.height    = heightTextField.text
        treesListManagedObject.origin    = originTextField.text
        treesListManagedObject.lore      = loreTextField.text
        treesListManagedObject.url       = urlTextField.text
        treesListManagedObject.image     = imageNameTextField.text
        
        // save
        do{
            try context.save()
        }catch{
            print("Core Data DOES NOT SAVE")
        }
        
        saveImage(name: imageNameTextField.text!)
        
    }
    
    
    func update(){
        
        
        // fill with data from textfields
        treesListManagedObject.name      = nameTextField.text
        treesListManagedObject.latinName = latinNameTextField.text
        treesListManagedObject.height    = heightTextField.text
        treesListManagedObject.origin    = originTextField.text
        treesListManagedObject.lore      = loreTextField.text
        treesListManagedObject.url       = urlTextField.text
        treesListManagedObject.image     = imageNameTextField.text
        
        
        // save
        do{
            try context.save()
        }catch{
            print("Core Data DOES NOT SAVE")
        }
        saveImage(name: imageNameTextField.text!)
        
    }
    
    // outlets and action
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var latinNameTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var originTextField: UITextField!
    @IBOutlet weak var loreTextField: UITextField!
    @IBOutlet weak var imageNameTextField: UITextField!
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var pickedImageView: UIImageView!
    
    @IBAction func pickImageAction(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            //set up the picker
            imagePicker.delegate      = self
            imagePicker.sourceType    = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            
            
            present(imagePicker, animated: true, completion: nil)
                        
        }
    }
    
    
    
    func  imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    // code to pick up an image from gallery
    let imagePicker = UIImagePickerController()
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // get the image from the picker
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage          // info is a dictionary
        
        // place the image to imageview
        pickedImageView.image = image
        
        // dismiss the picker
        dismiss(animated: true, completion: nil)
        
    }
    
    
    
    func saveImage(name: String){
        // get file manager
        let fm = FileManager.default
        // find path to Documents
        // convert the first element in the array to a string
        let docPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
        // append name to path
        let path = docPath.appendingPathComponent(name)
        
        // grab image data
        let data = pickedImageView.image!.pngData()
        
        // file manager save data
        fm.createFile(atPath: path, contents: data, attributes: nil)
        
    }
    
    func getImage(name: String){
        // get file manager
        let fm = FileManager.default
        
        // find path to Documents
        // convert the first element in the array to a string
        let docPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
        
        // append name to path
        let path = docPath.appendingPathComponent(name)
        
        // test if name exists and load it
        if fm.fileExists(atPath: path) {
            pickedImageView.image = UIImage(contentsOfFile: path)
        } else {
            print("FILE DOES NOT EXIST")
        }
        
    }
    

    
    @IBAction func addUpdateAction(_ sender: Any) {
        
        if treesListManagedObject != nil{
            update()
        }else{
            save()
        }


        // force navigation back to TVC
        navigationController?.popViewController(animated: true)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.title = "Add or Update"
        
        
        // call the background class and function
        let background = SetBackground(view: view, backgroundImage: "Images/treeBackground.jpg")
        background.setBackground()
        
        
        // present teh data of peopleManagedObject
        
        if treesListManagedObject != nil{
            nameTextField.text      = treesListManagedObject.name
            latinNameTextField.text = treesListManagedObject.latinName
            heightTextField.text    = treesListManagedObject.height
            originTextField.text    = treesListManagedObject.origin
            loreTextField.text      = treesListManagedObject.lore
            imageNameTextField.text = treesListManagedObject.image
            urlTextField.text       = treesListManagedObject.url
            
            if  imageNameTextField.text != nil{
                getImage(name:imageNameTextField.text!)
            }
            
        }
    }
    
} // end AddViewController class
