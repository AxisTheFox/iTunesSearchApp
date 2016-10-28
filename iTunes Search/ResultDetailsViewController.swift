//
//  ResultDetailsViewController.swift
//  iTunes Search
//
//  Created by Braydon Fox on 10/27/16.
//  Copyright © 2016 Braydon Fox. All rights reserved.
//

import UIKit

class ResultDetailsViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var detailsLabel1: UILabel!
    @IBOutlet weak var detailsLabel2: UILabel!
    @IBOutlet weak var detailsLabel3: UILabel!
    @IBOutlet weak var detailsLabel4: UILabel!
    @IBOutlet weak var detailsTextView: UITextView!
    
    var result:ResultObject? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = ""
        subtitleLabel.text = ""
        detailsLabel1.text = ""
        detailsLabel2.text = ""
        detailsLabel3.text = ""
        detailsLabel4.text = ""
        detailsTextView.text = ""
        detailsTextView.isEditable = false
        if let movie = result as? MovieResult {
            titleLabel.text = movie.trackName
            subtitleLabel.text = "Genre: " + movie.primaryGenreName
            detailsLabel4.text = "Price: $" + String(movie.trackHdPrice)
            detailsTextView.text = movie.longDescription
        } else if let software = result as? SoftwareResult {
            titleLabel.text = software.artistName
            subtitleLabel.text = "Genres: " + software.genres.joined(separator: ", ")
            detailsLabel4.text = "Compatible with: " + software.supportedDevices.joined(separator: ", ")
            detailsTextView.text = software.description
        } else if let av = result as? AudioVideoResult {
            titleLabel.text = av.trackName
            subtitleLabel.text = av.artistName
            detailsLabel1.text = av.collectionName
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
