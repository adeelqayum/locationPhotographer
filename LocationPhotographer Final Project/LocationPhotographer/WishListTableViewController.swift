//
//  WishListTableViewController.swift
//  LocationPhotographer
//
//  Created by Adeel Qayum on 12/3/18.
//  Copyright © 2018 Adeel Qayum. All rights reserved.
//

import UIKit

class WishListTableViewController: UITableViewController {
    
    let sectionTitles = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    var locations: [[String]] = [[], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], []]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func dismissButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)

    }
    @IBAction func onAddButton(_ sender: Any) {
        newLocation()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return locations[section].count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WishListCell", for: indexPath)

        cell.textLabel?.text = locations[indexPath.section][indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
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
            let firstLetter = addLocation.first
           
            for key in self.sectionTitles {
                if (String(firstLetter!) == key) {
                    let index = self.sectionTitles.index(of: key)
                    self.locations[index!].append(addLocation)
                    self.sortArray(array: self.locations)
                    print(self.locations)
                }
            }
            
            
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
    
    func sortArray(array: [[String]]) {
        var index = 0
        for array in locations {
            let sortedArray = array.sorted(by: <)
            locations[index] = sortedArray
            print(sortedArray)
            index += 1
        }
    }

}
