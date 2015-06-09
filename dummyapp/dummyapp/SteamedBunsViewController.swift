//
//  SteamedBunsViewController.swift
//  dummyapp
//
//  Created by raven on 6/9/15.
//  Copyright (c) 2015 raven. All rights reserved.
//

import UIKit
import MapKit

class SteamedBunsViewController: UIViewController {
    
    //@IBOutlet weak var testLabel: UILabel!
    @IBOutlet var testLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func updateUI() {
        // Anything...?
    }
    
    @IBAction func testButton(sender: UIButton) {
        var rand = random()
        testLabel.text = String(rand)+":"+String(rand%10)
        NSLog("rand is: " + String(rand%10))
        updateUI()
    }
}

