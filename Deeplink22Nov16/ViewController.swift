//
//  ViewController.swift
//  Deeplink22Nov16
//
//  Created by Puneeth Kumar  on 22/11/16.
//  Copyright © 2016 ASM Technologies Limited. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        // Do any additional setup after loading the view, typically from a nib.
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.triggerDeepLinkIfPresent()
    }


}

