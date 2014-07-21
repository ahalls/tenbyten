//
//  ViewController.swift
//  TenByTen
//
//  Created by Andrew Halls on 7/21/14.
//  Copyright (c) 2014 GaltSoft. All rights reserved.
//

import Foundation
import UIKit

class ViewController: UIViewController {
    @IBOutlet var imageView: UIImageView
    @IBOutlet var headerLabel: UILabel
    
    let managerImage = AFHTTPRequestOperationManager()
    let managerText =  AFHTTPRequestOperationManager()

                            
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        MMProgressHUD.show()
        managerText.responseSerializer =  AFHTTPResponseSerializer()
        
        managerText.GET("http://tenbyten.org/Data/global/Now/dateString.txt",
            parameters: nil,
            success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
                if (responseObject as? NSData) {
                    let dateString = NSString(data: responseObject as? NSData,  encoding: NSASCIIStringEncoding)
                    let fm = NSDateFormatter();
                    //2014/07/21/05
                
                    fm.dateFormat = "yyyy/MM/dd/HH\n"
                    let date = fm.dateFromString(dateString)
                    
                    println("dateString: \(dateString), date: \(date)");
                    
                    fm.dateFormat = "MMMM dd, yyyy"
                    self.headerLabel.text = fm.stringFromDate(date);
                    
                }
               },
            failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
                println("Error: " + error.localizedDescription)
            })
        

        
        
        managerImage.responseSerializer =  AFImageResponseSerializer()
        
        managerImage.GET("http://tenbyten.org/Data/global/Now/now.jpg",
            parameters: nil,
            success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in

                MMProgressHUD.dismiss()
                
                if responseObject as? UIImage {
                    self.imageView.image = responseObject as? UIImage
                }
                
            },
            failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
                MMProgressHUD.dismiss()
                println("Error: " + error.localizedDescription)
            })
        
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
