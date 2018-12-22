//
//  AppDelegate.swift
//  Project #3
//
//  Created by Adeel Qayum on 11/22/18.
//  Copyright © 2018 Adeel Qayum. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var locations: Locations!
    
    var dataFileName = "LocationFile"
    
    lazy var fileURL: URL = {
        let documentsDir =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsDir.appendingPathComponent(dataFileName, isDirectory: false)
    }()
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        loadData()
        if let navController = window?.rootViewController as? UINavigationController,
            let mainViewController = navController.viewControllers.first as? LocationTableViewController {
            mainViewController.locations = locations
        }
        
        
        let yourDate = Date()
        UserDefaults.standard.set(yourDate, forKey: "YourDefaultKey")
        
        
        let currentCount = UserDefaults.standard.integer(forKey: "launchCount")
        UserDefaults.standard.set(currentCount+1, forKey:"launchCount")
        UserDefaults.standard.synchronize()
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        saveData()
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        saveData()
    }
    
    
    func saveData() {
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(at: fileURL)
            } catch {
                fatalError(error.localizedDescription)
            }
        }
        
        if let encodedData = try? JSONEncoder().encode(locations) {
            FileManager.default.createFile(atPath: fileURL.path, contents: encodedData, attributes: nil)
        } else {
            fatalError("Couldn't write data!")
        }
    }
    
    func loadData() {
        
        if !FileManager.default.fileExists(atPath: fileURL.path) {
            locations = Locations()
            return
        }
        
        if let jsondata = FileManager.default.contents(atPath: fileURL.path) {
            let decoder = JSONDecoder()
            do {
                locations = try decoder.decode(Locations.self, from: jsondata)
            } catch {
                fatalError(error.localizedDescription)
            }
        } else {
            fatalError("No data at \(fileURL.path)!")
        }
    }
    
    
}
