//
//  Day6.swift
//  AdventOfCode
//

import Foundation

enum LightState {
    case ON
    case OFF
}

struct Light {
    var state: LightState

    init() {
        state = .OFF
    }

    mutating func toggle() {
        if state == .ON {
            state = .OFF
        } else {
            state = .ON
        }
    }

    var isOn: Bool {
        return state == .ON
    }
}

enum Command: String {
    case ON = "on"
    case OFF = "off"
    case TOGGLE = "toggle"
}

struct Position {
    let x: Int
    let y: Int

    init(_ input: String) {
        let components = input.componentsSeparatedByString(",")
        x = Int(components[0])!
        y = Int(components[1])!
    }
}

struct ParsedInstruction {
    let command: String
    let lowerCorner: Position
    let upperCorner: Position

    init(_ string: String) {
        let components = string.componentsSeparatedByString(" ")
        command = components[0]
        lowerCorner =  Position(components[1])
        upperCorner = Position(components[3])
    }
}

struct Instruction: CustomStringConvertible {
    let command: Command
    let lowerCorner: Position
    let upperCorner: Position

    var description: String {
        return "\(command) \(lowerCorner) \(upperCorner)"
    }
}

func createInstruction(rawCommand: String) -> Instruction? {
    let parsedCommand = ParsedInstruction(rawCommand)

    guard let command = Command(rawValue: parsedCommand.command) else {
        return nil
    }

    return Instruction(
        command: command,
        lowerCorner: parsedCommand.lowerCorner,
        upperCorner: parsedCommand.upperCorner
    )
}

func day6() {
    let input = readInputFile("day6-input")
        .componentsSeparatedByString("\n")
        .filter { !$0.isEmpty }
        .map { $0.stringByReplacingOccurrencesOfString("turn on", withString: "on") }
        .map { $0.stringByReplacingOccurrencesOfString("turn off", withString: "off") }

    let instructions = input.map { createInstruction($0) }
    let million = 1000 * 1000
    var grid = Array<Light>(count: million, repeatedValue: Light())

    for instruction in instructions {
        grid = applyInstruction(instruction!, toLightGrid: grid)
    }

    let litLightsCount = grid.reduce(0) { (counter, light) -> Int in
        return counter + (light.isOn ? 1 : 0)
    }
    print("Answer (PART I) \(litLightsCount)")
    assert(litLightsCount == 377891)
}

func applyInstruction(instruction: Instruction, var toLightGrid grid: [Light]) -> [Light] {
    let xRange = instruction.lowerCorner.x ... instruction.upperCorner.x
    let yRange = instruction.lowerCorner.y ... instruction.upperCorner.y
    let gridWidth = 1000

    for y in yRange {
        for x in xRange {
            let location = x + y * gridWidth

            switch instruction.command {
            case .OFF:
                grid[location].state = .OFF
            case .ON:
                grid[location].state = .ON
            case .TOGGLE:
                grid[location].toggle()
            }
        }
    }
    return grid
}
