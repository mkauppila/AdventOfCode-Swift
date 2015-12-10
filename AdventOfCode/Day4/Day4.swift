//
//  Day4.swift
//  AdventOfCode
//
//  Created by Markus Kauppila on 10/12/15.
//  Copyright © 2015 Markus Kauppila. All rights reserved.
//

import Foundation

func day4() {
    // Quick sanity check for the hashing function
    assert(MD5("hello world") == "5eb63bbbe01eeed093cb22bb8f5acdc3")

    let input = "iwrupvqb"

    let answerOne = findHashStartingWith("00000", input: input)
    print("Answer (PART I): \(answerOne)")
    assert(answerOne == 346386)

    // Brute forcing the answer takes 10+ minutes
    let answerTwo = findHashStartingWith("000000", input: input)
    print("Answer (PART II): \(answerTwo)")
    assert(answerTwo == 9958218)
}

func findHashStartingWith(prefix: String, input: String) -> Int {
    for value in naturalNumbers() {
        if let result = MD5("\(input)\(value)") {
            if result.hasPrefix(prefix) {
                return value
            }
        }
    }

    return 0
}

func naturalNumbers() -> AnyGenerator<Int> {
    var i = 0
    return anyGenerator { return i++ }
}

func MD5(value: String) -> String? {
    let stringEncoding = NSUTF8StringEncoding

    guard let input = value.cStringUsingEncoding(stringEncoding) else {
        return nil
    }

    let inputLength = CUnsignedInt(value.lengthOfBytesUsingEncoding(stringEncoding))
    let digestLength = Int(CC_MD5_DIGEST_LENGTH)

    let result = UnsafeMutablePointer<CUnsignedChar>.alloc(digestLength)
    CC_MD5(input, inputLength, result)

    // format hex string
    let hash = NSMutableString()
    for i in 0..<digestLength {
        hash.appendFormat("%02x", result[i])
    }

    result.destroy()

    return String(format: hash as String)
}

