//
//  LocationListDetailTableViewController.swift
//  LocationLists
//
//  Created by Michael Pujol on 9/19/17.
//  Copyright © 2017 Michael Pujol. All rights reserved.
//

import UIKit

class LocationListDetailTableViewController: UITableViewController {

    var locationList: LocationList?
    
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var listLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        //check to see if you are modifying or creating a new location list
        
        if locationList != nil {
            updateUI()
        } else {
            locationList = LocationList(name: "", list: [])
            updateUI()
        }
        
        
        
    }
    
    func updateUI() {
        
        if let locationList = locationList {
            nameTextField.text = locationList.name
            
            statusLabel.text = locationList.isActive ? "Active" : "Inactive"
            locationLabel.text = "location count: 0"
            listLabel.text = "Item count: \(locationList.list.count)"
        } else {
            nameTextField.text = ""
            statusLabel.text = "N/A"
            locationLabel.text = "location count: 0"
            listLabel.text = "Item count: 0"
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        if let header = view as? UITableViewHeaderFooterView {
            header.textLabel?.textColor = UIColor.black
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0
    }

    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    
     
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if let currentSegueIdentifier = segue.identifier {
            
            switch currentSegueIdentifier {
            case "saveUnwind":
                if let locationList = locationList {
                    let name = nameTextField.text ?? ""
                    
                    var list: [Item] = []
                    
                    if !locationList.list.isEmpty {
                        list = locationList.list
                    }
                    
                    self.locationList = LocationList(name: name, list: list)
                    print(locationList)
                    
                }
            default:
                break
            }
            
        }
        
    }
    

}
