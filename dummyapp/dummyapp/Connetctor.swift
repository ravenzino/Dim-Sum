//
//  Connetctor.swift
//  dummyapp
//
//  Created by raven on 15/6/1.
//  Copyright (c) 2015年 raven. All rights reserved.
//

import Foundation

let NOTI_NAME="Dummyapp.timelabel.change"


let hostAddr = "http://120.25.153.163:8000"


class Connector: NSObject {
    
    private var sessioncfg: NSURLSessionConfiguration!
    private var session: NSURLSession!

    
    override init() {
        super.init()
        
        sessioncfg = NSURLSessionConfiguration.defaultSessionConfiguration()
        session = NSURLSession(configuration: sessioncfg)
    }

    
    /* do HTTP exchange: send and receive
    // return nil for error
    */
    func doHTTPexchange(command: String, body: String?, handler: ((String) -> Void)?) -> Void {
        
        let validhttpmethod = ["GET", "POST"]
        assert(contains(validhttpmethod, command), "Invaild HTTP Method: \(command)")
        
        var request = NSMutableURLRequest(URL: NSURL(string: hostAddr)!)
        request.HTTPMethod = command
        if body != nil {
            request.HTTPBody = (body! as NSString).dataUsingEncoding(NSUTF8StringEncoding)
        }
    
        var task = session.dataTaskWithRequest(request, completionHandler: {(data: NSData!, response: NSURLResponse!, error: NSError!) in

            if error != nil {
                println("error: \(error.localizedDescription)")
                if handler != nil { handler!("<server unreachable>") }
                return
            } else if data != nil {
                var svmessage = NSString(data: data, encoding: NSUTF8StringEncoding)!
                println("data: \(svmessage)")
                if handler != nil { handler!(svmessage as String) }
            }
            
        })
        
        task.resume()
    }
    
    // Send the message out and retrive the response
    // Return nil indicating error
    // otherwise return the response message
    func sendMessage(message: String, hdlr: (String) -> Void) {
        doHTTPexchange("POST", body: message, handler: hdlr)
    }
    
    // Send request to server and retrive the time message
    // Return "" indicating error
    func getTime(hdlr: (String)->Void) -> Void {
        doHTTPexchange("GET", body: nil, handler: hdlr)
    }
}