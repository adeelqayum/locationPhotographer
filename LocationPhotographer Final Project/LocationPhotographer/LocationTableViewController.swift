//
//  LocationTableViewController.swift
//  Project #3
//
//  Created by Adeel Qayum on 11/22/18.
//  Copyright © 2018 Adeel Qayum. All rights reserved.
//

import UIKit
import CoreLocation

class LocationTableViewController: UITableViewController {
    
    var locations: Locations!
    var selectedLocation: LocationItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isToolbarHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.locationList.count
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        locations.removeItem(at: indexPath.row)
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! TableViewCell
        
        
        if let location = locations?.locationList[indexPath.row] {
            cell.locationLabel?.text = location.title
        }
        else {
            cell.locationLabel?.text = " "
        }
        
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        
        return cell
        
    }
    
    
    @IBAction func onAddBtn(_ sender: UIBarButtonItem) {
        newLocation()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "detailViewController") {
            if let destination = (segue.destination as? UITabBarController)?.viewControllers?.first as? InformationViewController {
                destination.selectedLocation = locations.locationList[(tableView.indexPathForSelectedRow?.row)!]
            }
            if let destination1 = (segue.destination as? UITabBarController)?.viewControllers?[2] as? WikiViewController {
                destination1.selectedLocation = locations.locationList[(tableView.indexPathForSelectedRow?.row)!]
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedLocation = locations.locationList[indexPath.row]
        performSegue(withIdentifier: "detailViewController", sender: UITouch())
    }
    
    func getFirstLetter(location: String) -> String {
        if let letter = location.first {
            return String(letter)
        }
        return " "
    }
    
    func newLocation() {
        
        let alert = UIAlertController(title: NSLocalizedString("str_alert", comment: ""),
                                      message: NSLocalizedString("str_alertmessage", comment: ""),
                                      preferredStyle: .alert)
        
        var locationTextField = UITextField()
        
        alert.addTextField { (locationField) in
            locationField.placeholder = NSLocalizedString("str_location", comment: "")
            locationTextField = locationField
        }
        
        
        let saveAction = UIAlertAction(title: NSLocalizedString("str_save", comment: ""), style: .destructive, handler: { _ in
            let addLocation = locationTextField.text!
            print(String(addLocation.first!))
            self.locations.add(title: addLocation)
            self.tableView.reloadData()
        })
        
        let cancelAction = UIAlertAction(title: NSLocalizedString("str_cancel", comment: ""),
                                         style: .cancel, handler:nil)
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        alert.popoverPresentationController?.permittedArrowDirections = []
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect = CGRect(x: self.view.frame.midX, y: self.view.frame.midY, width: 0, height: 0)
        
        
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
}
