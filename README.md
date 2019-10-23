# trees
Tree Identification App for iOS

John Linnane  -  University College Cork

iPhone Core Data App

****************************************

This application is a searchable database of tree species. This database uses Core Data, a framework developed by Apple which is used to manage the model layer object. Core Data uses SQLite as its persistent storage database. Persistent storage implies that data will be maintained after the device is shut off. 

An initial XML file was created, containing attributes of various species (name, height, origin etc.). The Foundation framework was used to create a class Species, which initialisas all of the variables. The TreeList class is then created to recieve parsed data from the XML file, using the XMLTreesParser class (which utilises the native XMLParser and XMLParserDelegate classes). The fromXMLToCoreData() function then creates a managed object for each attribute. This in turn is used to populate the text labels of different view controllers.  

This method was used in TableViewController to present a clickable list of different tree species. Each entry leads the user to a separate view controller containing a larger image and links to a details page. This details page contains the option to open a WebViewController, enabling the user to view an embedded external website relevant to the tree species.

The Click to add a tree!  button on the navigation bar of the homepage enables the user to input their own tree data and choose an image from the UIImagePickerController, which passes the image to Core Data using a delegate object. This creates a new entry in the TreeCoreDataModel entity, which then appears in the clickable list on the home screen. 
