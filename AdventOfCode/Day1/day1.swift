//
//  day1.swift
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

func day1() {
    let input = Array(readInputFile("day1-input").characters)

    let floorsUp = input.filter { $0 == "(" }.count
    let floorsDown = input.filter { $0 == ")" }.count

    print("answer (part 1): \(floorsUp - floorsDown)")
}