//
//  day2.swift
//  AdventOfCode
//
//  Created by Markus Kauppila on 09/12/15.
//  Copyright © 2015 Markus Kauppila. All rights reserved.
//

import Foundation

struct Dimensions {
    let lenght: Int
    let width: Int
    let height: Int

    func toArray() -> [Int] {
        return [lenght, width, height]
    }
}

func day2() {
    let input = readInputFile("day2-input").componentsSeparatedByString("\n")
                .filter { !$0.isEmpty }

    let sumOfNeededWrappingPaper =
        input.map { stringToDimensions($0) }
             .map { neededWrappingPaperForDimensions($0) }
             .reduce(0, combine: +)

    print("answer (part I): \(sumOfNeededWrappingPaper)")
    assert(sumOfNeededWrappingPaper == 1598415)

    let sumOfNeededRibbon =
        input.map { stringToDimensions($0) }
             .map { neededRibbonForDimensions($0) }
             .reduce(0, combine: +)

    print("answer (part II): \(sumOfNeededRibbon)")
    assert(sumOfNeededRibbon == 3812909)
}

func neededRibbonForDimensions(dimensions: Dimensions) -> Int {
    let dim = dimensions.toArray().sort()

    let ribbonForPresent = dim[0] * 2 + dim[1] * 2
    let ribbonForBow = dimensions.lenght * dimensions.width * dimensions.height

    return ribbonForPresent + ribbonForBow
}

func stringToDimensions(dimensions: String) -> Dimensions {
    let components = dimensions.componentsSeparatedByString("x")
    return Dimensions(lenght: Int(components[0])!,
                      width: Int(components[1])!,
                      height: Int(components[2])!)
}

func neededWrappingPaperForDimensions(dimensions: Dimensions) -> Int {
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