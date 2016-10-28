//
//  AudioVideoResult.swift
//  iTunes Search
//
//  Created by Braydon Fox on 10/26/16.
//  Copyright © 2016 Braydon Fox. All rights reserved.
//

import Foundation

class AudioVideoResult: ResultObject {
    var trackName = ""
    var artistName = ""
    var collectionName = ""
    var imageData:NSData? = nil
    var trackPrice:Double = 0.00
    var collectionPrice:Double = 0.00
}
