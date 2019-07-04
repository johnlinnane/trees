# trees
Tree Identification App for iOS

John Linnane  -  118227214  -  MSc Interactive Media 2018/2019

iPhone Core Data App

****************************************

Functionality

My application is a searchable database of tree species. This database uses Core Data, a framework developed by Apple which is used to manage the model layer object. Core Data uses SQLite as its persistent storage database. Persistent storage implies that data will be maintained after the device is shut off. 

An initial XML file was created, containing attributes of various species (name, height, origin etc.). The Foundation framework was used to create a class Species, which initialisas all of the variables. The TreeList class is then created to recieve parsed data from the XML file, using the XMLTreesParser class (which utilises the native XMLParser and XMLParserDelegate classes). The fromXMLToCoreData() function then creates a managed object for each attribute. This in turn is used to populate the text labels of different view controllers.  

This method was used in TableViewController to present a clickable list of different tree species. Each entry leads the user to a separate view controller containing a larger image and links to a details page. This details page contains the option to open a WebViewController, enabling the user to view an embedded external website relevant to the tree species.

The Click to add a tree!  button on the navigation bar of the homepage enables the user to input their own tree data and choose an image from the UIImagePickerController, which passes the image to Core Data using a delegate object. This creates a new entry in the TreeCoreDataModel entity, which then appears in the clickable list on the home screen. 


Personal Contributions / Design Elements

An app icon was added to the project, using the AppIcon section within the Assets folder. Icons for iphone require 60x60pt size, so I created an image of size 120x120px. 

I also added this icon to the navigation bar of the table view home screen. In my viewDidload() function I accessed the UINavigationItem variable in the extension of the UIViewController open class. I then applied some scaling to make the icon fit in the navigation bar. 

I created a SetBackground class in order to add my own background to each view controller. This contained a function which utilised the native NSLayoutAnchor, UIView and related classes to fix the image to the UIView, so that it would not get in the way when editing the storyboard.

I also added constraints to various UI elements to make the app compatible with various devices.

I added an animateTable() function which animates how the table elements are presented upon loading of the view controller.

To enhance readibility, I made my background image lighter in Photoshop so that there would be high contrast with the foreground. I also gave each view controller lots of space around elements so that they would not appear cluttered. Wherever possible, I tried to align similar elements. I also aimed to keep all imagery used to a consistent theme and colour scheme.



 
