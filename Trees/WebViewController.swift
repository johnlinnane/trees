//
//  WebViewController.swift
//  Trees
//
//  Created by John Linnane on 07/03/2019.
//  Copyright © 2019 UCC. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {

    
    @IBOutlet weak var urlTextView: UITextField!
    
    @IBOutlet weak var webView: WKWebView!
    
    
    var urlData : String!
    
    override func viewDidLoad() {
        
        // call the background class
        super.viewDidLoad()

        
        let background = SetBackground(view: view, backgroundImage: "Images/treeBackground.jpg")
        background.setBackground()
        

        // Do any additional setup after loading the view.
        self.title = "External Webpage"
        
        // make the webView to display the url
        
        if urlData != nil {
            // make the webview to display the url
            let url = URL(string: urlData)
            let request = URLRequest(url: url!)
            
            webView.load(request)
            
            webView.navigationDelegate = self
            
            //UITextView.text = urlData
            urlTextView.text = urlData
        }
        
    }
    
} // end WebViewController class

