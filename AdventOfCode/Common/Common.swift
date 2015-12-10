//
//  Common.swift
//  AdventOfCode
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

    func any(filter: (Element) -> Bool) -> Bool {
        for x in self where filter(x) {
            return true
        }
        return false
    }
}
