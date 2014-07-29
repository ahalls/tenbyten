//
//  TodayViewController.swift
//  Today
//
//  Created by Andrew Halls on 7/30/14.
//  Copyright (c) 2014 GaltSoft. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    let viewModel:ViewModel
    
    
    init(coder aDecoder: NSCoder!)  {
        viewModel = ViewModel(newsService: TenByTenService())
        super.init(coder:aDecoder)
    }
    init(viewModel:ViewModel, nibName: String? = nil, bundle: NSBundle? = nil) {

        self.viewModel = viewModel
        super.init(nibName: nibName, bundle: bundle)
        
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.preferredContentSize = CGSizeMake(0, 220);
        self.viewModel.image?.subscribeNext() {
            (responseObject:AnyObject!)  -> Void in
            if let image = responseObject as? UIImage {
                self.imageView!.image  = image;
            }
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        // Perform any setup necessary in order to update the view.

        // If an error is encoutered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        completionHandler(NCUpdateResult.NewData)
    }
    
}
