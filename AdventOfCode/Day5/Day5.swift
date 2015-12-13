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

    let niceStringsWithNewRules = input.filter { string in
        return hasNonOverlappingPairOfCharactersTwice(string) &&
               hasRepeatingLetterWithOneLetterBetweenThem(string)
    }
    let newNiceStringsCount = niceStringsWithNewRules.count
    print("Answer (PART II): \(newNiceStringsCount)")
    assert(newNiceStringsCount == 55)
}

// MARK: Part I

func isInstaNaughty(input: String) -> Bool {
    return ["ab", "cd", "pq", "xy"].any {
        input.containsString($0)
    }
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

// MARK: Part II

struct PotentialPair {
    let original: String
    let pair: String

    func pairAppearsTwice() -> Bool {
        let pairsRemoved = original.stringByReplacingOccurrencesOfString(pair, withString: "")
        return pairsRemoved.lengthWithUTF8Encoding() == original.lengthWithUTF8Encoding() - 4
    }
}

func PotentialPairFromString(string: String, fromIndex: Int) -> PotentialPair {
    let range = string.startIndex.advancedBy(fromIndex) ..< string.startIndex.advancedBy(fromIndex + 2)
    let pair = string[range]

    return PotentialPair(original: string, pair: pair)
}

func hasNonOverlappingPairOfCharactersTwice(input: String) -> Bool {
    var allPairs = Array<PotentialPair>()
    for index in 0 ... input.characters.count - 2 {
        allPairs.append(PotentialPairFromString(input, fromIndex: index))
    }

    return allPairs.any { $0.pairAppearsTwice() }
}

func hasRepeatingLetterWithOneLetterBetweenThem(input: String) -> Bool {
    let characters = input.characters
    for index in characters.startIndex ..< characters.endIndex.advancedBy(-2) {
        if characters[index] == characters[index.advancedBy(2)] {
            return true
        }
    }

    return false
}

