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

    
    let managerImage = AFHTTPRequestOperationManager()
    let managerText =  AFHTTPRequestOperationManager()
    let viewModel: ViewModel
    
    init(_viewModel:ViewModel) {
        self.viewModel = _viewModel
        super.init(nibName: "ViewController", bundle: nil)
    }
    
    func bindViewModel() {
        self.title = self.viewModel.title;
        
        self.viewModel.isExecuting?.subscribeNext() {
            (responseObject:AnyObject!)  -> Void in
            if let isExecuting = responseObject as? Bool {
                if (isExecuting) {
                    MMProgressHUD.show()
                }
                else {
                    MMProgressHUD.dismiss()
                }
            }
        }

        
        self.viewModel.dateTitle?.subscribeNext() {
            (responseObject:AnyObject!)  -> Void in
            if let date = responseObject as? NSDate {
                var fm = NSDateFormatter()
                    fm.dateFormat = "MMMM dd, yyyy"
                    self.headerLabel!.text = fm.stringFromDate( date)
            }
        }
        
        self.viewModel.image?.subscribeNext() {
             (responseObject:AnyObject!)  -> Void in
            if let image = responseObject as? UIImage {
                self.imageView!.image  = image;
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
        
    }



}

