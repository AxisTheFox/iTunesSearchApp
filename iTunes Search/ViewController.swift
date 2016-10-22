//
//  ViewController.swift
//  iTunes Search
//
//  Created by Braydon Fox on 10/17/16.
//  Copyright © 2016 Braydon Fox. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var entityPicker: UIPickerView!
    @IBOutlet weak var searchTextField: UITextField!
    
    let entityPickerData = ["Audio and Video", "Movies", "Software"]
    var selectedEntity = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        entityPicker.dataSource = self
        entityPicker.delegate = self
        selectedEntity = entityPickerData[0]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return entityPickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return entityPickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedEntity = entityPickerData[row]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as? ResultsTableViewController
        destination?.searchEntity = selectedEntity
        destination?.searchTerm = searchTextField.text!
        navigationItem.title = nil
    }

    @IBAction func searchButton(_ sender: AnyObject) {
        
    }

}

