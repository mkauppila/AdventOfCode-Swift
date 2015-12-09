//
//  day2.swift
//  AdventOfCode
//
//  Created by Markus Kauppila on 09/12/15.
//  Copyright © 2015 Markus Kauppila. All rights reserved.
//

import Foundation

struct Dimenensions {
    let lenght: Int
    let width: Int
    let height: Int
}

func day2() {
    let input = readInputFile("day2-input").componentsSeparatedByString("\n")
                .filter { !$0.isEmpty }

    let sumOfNeededWrappingPaper =
        input.map { stringToDimensions($0) }
             .map { neededWrappingPaperForDimesions($0) }
             .reduce(0, combine: +)

    print("answer: \(sumOfNeededWrappingPaper)")
    assert(sumOfNeededWrappingPaper == 1598415)
}

func stringToDimensions(dimensions: String) -> Dimenensions {
    let components = dimensions.componentsSeparatedByString("x")
    return Dimenensions(lenght: Int(components[0])!,
                        width: Int(components[1])!,
                        height: Int(components[2])!)
}

func neededWrappingPaperForDimesions(dimensions: Dimenensions) -> Int {
    let areasOfAllSides = [
        areaOfSide(dimensions.lenght, dimensions.width),
        areaOfSide(dimensions.width, dimensions.height),
        areaOfSide(dimensions.height, dimensions.lenght)
    ]

    let areaOfNeededWrappingPaper = areasOfAllSides.reduce(0, combine: +)
    let areaOfExtraWrappingPaper = areasOfAllSides.minElement()! / 2

    return areaOfNeededWrappingPaper + areaOfExtraWrappingPaper
}

func areaOfSide(lhs: Int, _ rhs: Int) -> Int {
    return 2 * lhs * rhs
}