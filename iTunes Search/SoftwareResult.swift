//
//  SoftwareResult.swift
//  iTunes Search
//
//  Created by Braydon Fox on 10/23/16.
//  Copyright © 2016 Braydon Fox. All rights reserved.
//

import Foundation

class SoftwareResult: ResultObject {
    var artistName = ""
    var price = 0.00
    var supportedDevices = [String]()
    var description = ""
    var genres = [String]()
    var screenshot1:NSData? = nil
    var screenshot2:NSData? = nil
}
