//
//  PlacesViewController.swift
//  listingdownplacetovisitusingmapkit
//
//  Created by Arsal Jamal on 26/09/2018.
//  Copyright © 2018 abdulahad. All rights reserved.
//

import UIKit
var places = [Dictionary<String,String>()]
//tells us the current active place which starts from 0 as table view starts from 0 ! if no activeplace selected from tableview
//so it should be -1
var activeplace = -1

class PlacesViewController: UITableViewController {

    @IBOutlet var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //array has dictionary which is empty so remove that and add sample
        
    }

    override func viewDidAppear(_ animated: Bool) {
        if places.count==1 && places[0].count==0{
            places.remove(at: 0)
            places.append(["name":"Taj Mahal","lat":"27.176277","lon":"78.04218"])
        }
        table.reloadData()
        activeplace = -1

    }
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete{
            places.remove(at: indexPath.row)
            table.reloadData()
        }
        
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return places.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if places[indexPath.row]["name"] != nil {
            cell.textLabel?.text=places[indexPath.row]["name"]
        }

        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        activeplace=indexPath.row
        performSegue(withIdentifier: "toMap", sender: nil)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
