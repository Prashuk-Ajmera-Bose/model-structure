//
//  ExtensionDelegate.swift
//  Model WatchKit Extension
//
//  Created by Prashuk Ajmera on 8/29/19.
//  Copyright © 2019 Prashuk Ajmera. All rights reserved.
//

import WatchKit

class ExtensionDelegate: NSObject, WKExtensionDelegate, WKExtendedRuntimeSessionDelegate {

    // Instance
    let wkSession = WKExtendedRuntimeSession()
    
    // Variables
    var flag = 0
    var count = 1
    
    func applicationDidFinishLaunching() {
        // Perform any final initialization of your application.
        
        wkSession.delegate = self
    }

    func applicationDidBecomeActive() {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        if flag == 0 {
            flag = 1
        } else {
            wkSession.invalidate()
            print("Session \(count - 1) stopped")
        }
        
        wkSession.start()
        
        print("Session \(count) started")
        count = count + 1
    }

    func applicationWillResignActive() {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, etc.
        
    }
    
    func applicationDidEnterBackground() {
        // Use this method when you are about to go Background
        
    }
    
    func applicationWillEnterForeground() {
        // Use this method when you are about to go Foreground
        
    }

    func handle(_ backgroundTasks: Set<WKRefreshBackgroundTask>) {
        // Sent when the system needs to launch the application in the background to process tasks. Tasks arrive in a set, so loop through and process each one.
        for task in backgroundTasks {
            // Use a switch statement to check the task type
            switch task {
            case let backgroundTask as WKApplicationRefreshBackgroundTask:
                // Be sure to complete the background task once you’re done.
                backgroundTask.setTaskCompletedWithSnapshot(false)
            case let snapshotTask as WKSnapshotRefreshBackgroundTask:
                // Snapshot tasks have a unique completion call, make sure to set your expiration date
                snapshotTask.setTaskCompleted(restoredDefaultState: true, estimatedSnapshotExpiration: Date.distantFuture, userInfo: nil)
            case let connectivityTask as WKWatchConnectivityRefreshBackgroundTask:
                // Be sure to complete the connectivity task once you’re done.
                connectivityTask.setTaskCompletedWithSnapshot(false)
            case let urlSessionTask as WKURLSessionRefreshBackgroundTask:
                // Be sure to complete the URL session task once you’re done.
                urlSessionTask.setTaskCompletedWithSnapshot(false)
            case let relevantShortcutTask as WKRelevantShortcutRefreshBackgroundTask:
                // Be sure to complete the relevant-shortcut task once you're done.
                relevantShortcutTask.setTaskCompletedWithSnapshot(false)
            case let intentDidRunTask as WKIntentDidRunRefreshBackgroundTask:
                // Be sure to complete the intent-did-run task once you're done.
                intentDidRunTask.setTaskCompletedWithSnapshot(false)
            default:
                // make sure to complete unhandled task types
                task.setTaskCompletedWithSnapshot(false)
            }
        }
    }
    
    // MARK: WKExtended Runtime Session Delegate
    
    func extendedRuntimeSession(_ extendedRuntimeSession: WKExtendedRuntimeSession, didInvalidateWith reason: WKExtendedRuntimeSessionInvalidationReason, error: Error?) {
        
    }
    
    func extendedRuntimeSessionDidStart(_ extendedRuntimeSession: WKExtendedRuntimeSession) {
        
    }
    
    func extendedRuntimeSessionWillExpire(_ extendedRuntimeSession: WKExtendedRuntimeSession) {
        
    }
    
    // MARK: User Defined Functions
    
    // Get state  for Extended Runtime Session
    func getStateForExtendedRuntimeSession() {
        switch wkSession.state {
        case .notStarted:
            print("Not Started")
        case .running:
            print("Running")
        case .invalid:
            print("Invalid")
        case .scheduled:
            print("Scheduled")
        default:
            print("None")
        }
    }
    
    // Get state  for Extended Runtime Session
    func getApplicationState() {
        switch WKExtension().applicationState {
        case .active:
            print("Active")
        case .background:
            print("Background")
        case .inactive:
            print("Inactive")
        default:
            print("Default")
        }
    }

}
