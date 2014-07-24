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
    @IBOutlet var imageView: UIImageView?
    @IBOutlet var headerLabel: UILabel?
    @IBOutlet weak var textField: UITextField!
    
    let managerImage = AFHTTPRequestOperationManager()
    let managerText =  AFHTTPRequestOperationManager()
    let viewModel: ViewModel
    
    init(_viewModel:ViewModel) {
        self.viewModel = _viewModel
        super.init(nibName: "ViewController", bundle: nil)
    }
    
    func bindViewModel() {
        self.title = self.viewModel.title;
        
        self.viewModel.dateTitle?.subscribeNext() {
            (responseObject:AnyObject!)  -> Void in
            if let date = responseObject as? NSDate {
                var fm = NSDateFormatter()
                    fm.dateFormat = "MMMM dd, yyyy"
                    self.headerLabel!.text = fm.stringFromDate( date)
            }
        }
        
//        self.viewModel.connectionErrors?.subscribeError() {
//            (responseObject:AnyObject!)  -> Void in
//            if let error = responseObject as ? NSError {
//                let alert = UIAlertView(title: "Connection Error", message: error.description , delegate: nil, cancelButtonTitle: OK, otherButtonTitles: nil, nil)
//                alert.show()
//            }
//        }
    }
//         self.viewModel.connectionErrors.subscribeNext()
//        :^(NSError *error) {
//            UIAlertView *alert =
//            [[UIAlertView alloc] initWithTitle:@"Connection Error"
//            message:@"There was a problem reaching Flickr."
//            delegate:nil
//            cancelButtonTitle:@"OK"
//            otherButtonTitles:nil];
//            [alert show];
//            }];
        


     override func viewDidLoad() {
        
        super.viewDidLoad()
        
        bindViewModel()
        

        
        MMProgressHUD.show()
        managerText.responseSerializer =  AFHTTPResponseSerializer()
        
       var request =  managerText.rac_GET("http://tenbyten.org/Data/global/Now/dateString.txt",
            parameters: nil)
        
        request.subscribeNext() {(responseObject:AnyObject!)  -> Void in
            if let data = responseObject as? NSData {
                // Causes error in compiler
               //var date =  data.tbt_date //    NSData_TenByTen.dateFromData(data)
               let date = NSData_TenByTen.dateFromData(data)
                var fm = NSDateFormatter()
                fm.dateFormat = "MMMM dd, yyyy"
                println(fm.stringFromDate( date))
            }
       }
        
       request.subscribeError(){(error:NSError!) -> Void in
         println("Error: " + error!.localizedDescription)
       }
        
 
//        [[manager rac_GET:path parameters:params] subscribeNext:^(id JSON) {
//            //Voila, magical JSON…
//            }];
        
//        managerText.GET("http://tenbyten.org/Data/global/Now/dateString.txt",
//            parameters: nil,
//            success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
//                if (responseObject as? NSData) {
//                    let dateString = NSString(data: responseObject as? NSData,  encoding: NSASCIIStringEncoding)
//                    let fm = NSDateFormatter();
//                    //2014/07/21/05
//                
//                    fm.dateFormat = "yyyy/MM/dd/HH\n"
//                    let date = fm.dateFromString(dateString)
//                    
//                    println("dateString: \(dateString), date: \(date)");
//                    
//                    fm.dateFormat = "MMMM dd, yyyy"
//                    self.headerLabel!.text = fm.stringFromDate(date);
//                    
//                }
//               },
//            failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
//                println("Error: " + error.localizedDescription)
//            })
//       
        var imageRequest = NSURLRequest( URL:  NSURL(string: "http://tenbyten.org/Data/global/Now/now.jpg"))
      self.imageView!.setImageWithURLRequest( imageRequest,
           placeholderImage: nil,
           success: {(request: NSURLRequest? ,response: NSHTTPURLResponse? ,image: UIImage?) -> Void
               in self.imageView!.image = image
                MMProgressHUD.dismiss() },
           failure: { (request: NSURLRequest?, response: NSHTTPURLResponse?, error: NSError?) -> Void
                in MMProgressHUD.dismiss()
               println("Error: " + error!.localizedDescription) })


       textField.rac_textSignal().subscribeNext() {(value:AnyObject!) -> Void in
           var text : String = value as String
           println("text: \(text)")
        }
//
////        [self.textField.rac_textSignalsubscribeNext:^(idx){ NSLog(@"New value: %@", x);
//            }error:^(NSError*error){ NSLog(@"Error: %@", error);
//            }completed:^{ NSLog(@"Completed.");
//            }];
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



}

