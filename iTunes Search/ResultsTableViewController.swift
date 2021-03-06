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
    var searchURL = ""
    var resultsData:NSArray = []
    var resultsObjects = [ResultObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Results"
        let searchURL = buildSearchUrlString()
        let urlAsString = searchURL
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
    
    func buildSearchUrlString() -> String {
        searchTerm = searchTerm.replacingOccurrences(of: " ", with: "+")
        if (searchEntity == "Movies") {
            searchTerm = searchTerm + "&entity=movie"
        }
        if (searchEntity == "Software") {
            searchTerm = searchTerm + "&entity=software"
        }
        let baseSearchURL = "http://itunes.apple.com/search?term="
        return baseSearchURL + searchTerm
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "cell")
        let rowData:NSDictionary = (self.resultsData[indexPath.row] as? NSDictionary)!
        if (searchEntity == "Movies") {
            let m = MovieResult()
            m.trackName = (rowData["trackName"] as? String)!
            m.contentAdvisoryRating = (rowData["contentAdvisoryRating"] as? String)!
            m.imageData = NSData(contentsOf: (URL(string: (rowData["artworkUrl30"] as? String)!))!)
            m.longDescription = (rowData["longDescription"] as? String)!
            m.primaryGenreName = (rowData["primaryGenreName"] as? String)!
            m.trackHdPrice = (rowData["trackHdPrice"] as? Double)!
            resultsObjects.append(m)
        } else if (searchEntity == "Software") {
            let s = SoftwareResult()
            s.artistName = (rowData["artistName"] as? String)!
            s.price = (rowData["price"] as? Double)!
            s.supportedDevices = (rowData["supportedDevices"] as? Array)!
            s.description = (rowData["description"] as? String)!
            s.genres = (rowData["genres"] as? Array)!
            resultsObjects.append(s)
        } else {
            let av = AudioVideoResult()
            av.trackName = (rowData["trackName"] as? String)!
            av.artistName = (rowData["artistName"] as? String)!
            av.imageData = NSData(contentsOf: (URL(string: (rowData["artworkUrl30"] as? String)!))!)
            resultsObjects.append(av)
        }
        
        if (searchEntity == "Movies") {
            cell.textLabel?.text = (resultsObjects[(indexPath as NSIndexPath).row] as! MovieResult).trackName
            cell.detailTextLabel?.text = (resultsObjects[(indexPath as NSIndexPath).row] as! MovieResult).contentAdvisoryRating
            cell.imageView?.image = UIImage(data: ((resultsObjects[(indexPath as NSIndexPath).row]) as! MovieResult).imageData as! Data)
        } else if (searchEntity == "Software") {
            cell.textLabel?.text = (resultsObjects[(indexPath as NSIndexPath).row] as! SoftwareResult).artistName
            cell.detailTextLabel?.text = String((resultsObjects[(indexPath as NSIndexPath).row] as! SoftwareResult).price)
        } else {
            cell.textLabel?.text = (resultsObjects[(indexPath as NSIndexPath).row] as! AudioVideoResult).trackName
            cell.detailTextLabel?.text = (resultsObjects[(indexPath as NSIndexPath).row] as! AudioVideoResult).collectionName
            cell.imageView?.image = UIImage(data: ((resultsObjects[(indexPath as NSIndexPath).row]) as! AudioVideoResult).imageData as! Data)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showResultDetails", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as? ResultDetailsViewController
        let index = ((sender as! IndexPath) as NSIndexPath).row
        destination?.result = resultsObjects[index]
        navigationItem.title = "Details"
    }

}
