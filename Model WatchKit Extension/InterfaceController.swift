//
//  InterfaceController.swift
//  Model WatchKit Extension
//
//  Created by Prashuk Ajmera on 8/29/19.
//  Copyright © 2019 Prashuk Ajmera. All rights reserved.
//

import WatchKit
import Foundation
import CoreMotion

class InterfaceController: WKInterfaceController {
    
    let cmMotion = CMMotionManager()
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
    }
    
    override func willActivate() {
        super.willActivate()
        
    }
    
    override func didDeactivate() {
        super.didDeactivate()
        
    }
    
    // MARK: User Defined Functions
    
    func myDeviceMotion() {
       if cmMotion.isDeviceMotionAvailable {
           self.cmMotion.deviceMotionUpdateInterval = 1.0 / 60.0
           self.cmMotion.showsDeviceMovementDisplay = true
           self.cmMotion.startDeviceMotionUpdates(to: OperationQueue.current!) { (data, error) in
              if let newData = data {
//                print(newData)
                print(newData.userAcceleration.x)
              }
           }
        }
    }
    
    // MARK: Button Actions
    
    @IBAction func startSessionBtnPressed() {
        
    }
    
    @IBAction func getRuntimeStateBtnPressed() {
        
    }
    
    @IBAction func getIMUDataBtnPressed() {
        myDeviceMotion()
    }
    
}
