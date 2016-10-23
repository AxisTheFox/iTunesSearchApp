//
//  ResultsTableViewController.swift
//  iTunes Search
//
//  Created by Braydon Fox on 10/21/16.
//  Copyright © 2016 Braydon Fox. All rights reserved.
//

import UIKit

class ResultsTableViewController: UITableViewController {
    
    var searchEntity = ""
    var searchTerm = ""
    let baseSearchURL = "http://itunes.apple.com/search?term="
    var resultsData:NSArray = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Results"
        searchTerm = searchTerm.replacingOccurrences(of: " ", with: "+")
        let urlAsString =  baseSearchURL + searchTerm
        let url = URL(string: urlAsString)
        let urlSession = URLSession.shared
        let task = urlSession.dataTask(with: url!, completionHandler: { (data, response, error) -> Void in
            print("Task completed.")
            if(error != nil) {
                print(error!.localizedDescription)
            }
            do {
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                    if let results:NSArray = jsonResult["results"] as? NSArray {
                        DispatchQueue.main.async(execute: {
                            self.resultsData = results
                            self.tableView!.reloadData()
                        })
                    }
                }
            }
            catch {}
        })
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultsData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "cell")
        if let rowData: NSDictionary = self.resultsData[indexPath.row] as? NSDictionary,
        let urlString = rowData["artworkUrl30"] as? String,
        let imgURL = URL(string: urlString),
        let trackPrice = rowData["trackPrice"] as? Double,
            let imgData = NSData(contentsOf: imgURL),
            let trackName = rowData["trackName"] as? String {
            cell.detailTextLabel?.text = "$" + trackPrice.description
            cell.imageView?.image = UIImage(data: imgData as Data)
            cell.textLabel?.text = trackName
        }
        return cell
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
