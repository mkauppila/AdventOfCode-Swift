//
//  Day5.swift
//  AdventOfCode
//

import Foundation

func day5() {
    let input = readInputFile("day5-input")
        .componentsSeparatedByString("\n")
        .filter { !$0.isEmpty }

    let niceStrings = input.filter { string in
        return !isInstaNaughty(string) &&
               hasConsecutiveCharacters(string) &&
               hasAtleastThreeVowels(string)
    }

    let niceStringsCount = niceStrings.count
    print("Answer (PART I): \(niceStringsCount)")
    assert(niceStringsCount == 255)
}

func isInstaNaughty(input: String) -> Bool {
    return ["ab", "cd", "pq", "xy"].any({
        input.containsString($0)
    })
}

func hasConsecutiveCharacters(input: String) -> Bool {
    var prevCharacter = input.characters.first!

    for character in input.characters.dropFirst() {
        if prevCharacter == character {
            return true
        }

        prevCharacter = character
    }

    return false
}

func hasAtleastThreeVowels(input: String) -> Bool {
    let vowels = ["a", "e", "i", "o", "u"]

    var count = 0
    for character in input.characters where vowels.contains(String(character)) {
        count++
    }

    return count >= 3
}