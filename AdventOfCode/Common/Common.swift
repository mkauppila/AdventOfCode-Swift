//
//  Common.swift
//  AdventOfCode
//
//  Created by Markus Kauppila on 09/12/15.
//  Copyright © 2015 Markus Kauppila. All rights reserved.
//

import Foundation

func readInputFile(fileName: String) -> String {
    let path = NSBundle.mainBundle().pathForResource(fileName, ofType: "txt")
    return try! String(contentsOfFile: path!)
}
