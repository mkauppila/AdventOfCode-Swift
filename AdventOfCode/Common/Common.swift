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

extension String {
    func isEmpty() -> Bool {
        return self.characters.count == 0
    }
}

extension Array {
    func filterWithIndex(includeElement: (Element, Index) -> Bool) -> [Element] {
        var results: [Element] = []
        var index = 0
        for x in self {
            if includeElement(x, index) {
                results.append(x)
            }
            index++
        }
        return results
    }
}
