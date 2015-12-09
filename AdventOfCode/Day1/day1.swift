//
//  day1.swift
//  AdventOfCode
//
//  Created by Markus Kauppila on 09/12/15.
//  Copyright © 2015 Markus Kauppila. All rights reserved.
//

import Foundation

func day1() {
    let input = Array(readInputFile("day1-input").characters)

    let floorsUp = input.filter { $0 == "(" }.count
    let floorsDown = input.filter { $0 == ")" }.count

    let answer = floorsUp - floorsDown
    print("answer (part 1): \(answer)")
    assert(answer == 74)

    let position = characterPositionOfDescendingToBasement(input)
    print("answer (part 2): \(position)")
    assert(position == 1795)
}

func characterPositionOfDescendingToBasement(input: Array<Character>) -> Int {
    var floorLevel = 0
    var indexOfDescent = 1
    var index = 1

    for character in input {
        if character == "(" {
            floorLevel++
        } else {
            floorLevel--
        }

        if (floorLevel < 0) {
            indexOfDescent = index
            break;
        }

        index++
    }

    return indexOfDescent
}
