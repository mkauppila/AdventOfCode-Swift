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

    for value in naturalNumbers() {
        if let result = MD5("\(input)\(value)") {
            if result.hasPrefix("00000") {
                print("Answer (PART I): \(value)")
                break
            }
        }
    }
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

