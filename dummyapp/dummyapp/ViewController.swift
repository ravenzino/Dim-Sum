//
//  ViewController.swift
//  dummyapp
//
//  Created by raven on 15/5/30.
//  Copyright (c) 2015年 raven. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var connectStatusLabel: UILabel!
    @IBOutlet weak var serverMessage: UITextView!
    @IBOutlet weak var userInput: UITextField!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet weak var testLabel: UILabel!
    
    private var connector: Connector!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        connector = Connector()
        serverMessage.attributedText = NSAttributedString(string: String(""))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func timeStamp() -> String {
        var date = NSDate()
        var formatter = NSDateFormatter()
        formatter.dateFormat = "[HH:mm:ss] "
        return formatter.stringFromDate(date)
    }
    
    private func scrollDown() {
        serverMessage.scrollRangeToVisible(NSMakeRange(count(serverMessage.text), 0))
        serverMessage.setNeedsDisplay()
    }
    
    private func appendMessage(message: String) {
        serverMessage.text.extend(timeStamp() + message + "\n")
    }
    
    private func commit() {
        if (count(userInput.text) <= 0) {
            return
        }
        appendMessage(userInput.text)
        connector.sendMessage(userInput.text, hdlr: { (str: String) -> Void in
            dispatch_async(dispatch_get_main_queue(), {
                self.appendMessage(str)
                self.scrollDown()
            })
        })
        userInput.text = ""
    }
    
    private func updateUI() {
        // Anything...?
    }

    @IBAction func sendMessage(sender: UIButton) {
        commit()
        updateUI()
    }
    
    @IBAction func hitEnter(sender: UITextField) {
        commit()
        userInput.becomeFirstResponder()
        updateUI()
    }

    @IBAction func getServerTime(sender: UIButton) {
        connector.getTime({(str: String) in
            dispatch_async(dispatch_get_main_queue(), {
                self.timeLabel.text = str
                self.timeLabel.setNeedsDisplay()
                //self.timeLabel.setNeedsLayout()
            })
        })
        updateUI()
    }
    
    
    @IBAction func testButton(sender: UIButton) {
        var rand = random()
        testLabel.text = String(rand)+":"+String(rand%10)
        NSLog("rand is: " + String(rand%10))
        updateUI()
    }
}

