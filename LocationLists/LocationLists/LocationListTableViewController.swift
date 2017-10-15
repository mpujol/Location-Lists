//
//  LocationListTableViewController.swift
//  LocationLists
//
//  Created by Michael Pujol on 9/18/17.
//  Copyright © 2017 Michael Pujol. All rights reserved.
//

import UIKit

class LocationListTableViewController: UITableViewController {

    var locationLists: [LocationList] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//         self.navigationItem.rightBarButtonItem = editButtonItem
        
        //Load the data

        if let savedLocationLists = LocationList.loadLocationLists() {
            locationLists = savedLocationLists
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return locationLists.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let reuseIdentifier = "LocationListCell"
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)

        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? LocationListCell else { fatalError("Unable to dequeue location list cell") }
        
        // Configure the cell...
        
        let locationList = locationLists[indexPath.row]
        
        cell.nameLabel.text = locationList.name
        cell.listLabel.text = "\(locationList.inactiveLists) out of \(locationList.list.count) Complete"
        
        
        cell.listProgressView.progress = locationList.list.isEmpty ? 0.0 : locationList.progress
        cell.statusLevel.text = locationList.isActive ? "Active" : "Inactive"
        

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    @IBAction func unwindLocationListDetail(segue: UIStoryboardSegue) {

        // collect the saved Location list if the save button is pressed otherwise break
        
        guard segue.identifier == "saveUnwind" else { return }
        
        let sourceViewController = segue.source as? LocationListDetailTableViewController
        
        if let locationList = sourceViewController?.locationList {

            //Check to see if there is an item that was selected
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                print("Found a selected index at \(selectedIndexPath)")
                // you need to overwrite the information at the selected path
                
                locationLists[selectedIndexPath.row] = locationList
                tableView.reloadData()
            
            } else {
                //No item is selected to include it at the end of the location list array
                
                let newLocationListIndexPath = IndexPath(row: locationLists.count, section: 0)
                locationLists.append(locationList)
                
                tableView.insertRows(at: [newLocationListIndexPath], with: .automatic)
                
            }
            
            //TODO: Save new or overwritten information
            
            LocationList.saveLocationLists(locationLists)
        
        }
        
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier ==  "showLocationListDetail" {
            let locationListDetailVC = segue.destination as! LocationListDetailTableViewController
            if let indexPath = tableView.indexPathForSelectedRow {
                locationListDetailVC.locationList = locationLists[indexPath.row]
            }
        }
        
        
        
    }
    

}
