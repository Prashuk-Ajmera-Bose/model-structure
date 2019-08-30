//
//  ViewController.swift
//  Model
//
//  Created by Prashuk Ajmera on 8/29/19.
//  Copyright © 2019 Prashuk Ajmera. All rights reserved.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController, WCSessionDelegate {
    
    let session = WCSession.default
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
         let receivedGlobal = applicationContext["my_global"]
        print(receivedGlobal!)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        session.delegate = self
        
    }


}

