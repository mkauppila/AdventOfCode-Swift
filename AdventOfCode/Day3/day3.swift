//
//  day3.swift
//  AdventOfCode
//
//  Created by Markus Kauppila on 09/12/15.
//  Copyright © 2015 Markus Kauppila. All rights reserved.
//

import Foundation

enum Direction: String {
    case North = "^"
    case South = "v"
    case West = "<"
    case East = ">"
}

struct Location: Hashable, Equatable, CustomStringConvertible {
    let x: Int
    let y: Int

    var hashValue: Int {
        return x ^ y
    }

    var description: String {
        return "(\(x), \(y))"
    }
}

func ==(lhs: Location, rhs: Location) -> Bool {
    return lhs.x == rhs.x && lhs.y == rhs.y
}

func newLocationToDirection(location: Location, direction: Direction) -> Location {
    switch direction {
    case .North:
        return Location(x: location.x, y: location.y + 1)
    case .South:
        return Location(x: location.x, y: location.y - 1)
    case .West:
        return Location(x: location.x  - 1, y: location.y)
    case .East:
        return Location(x: location.x  + 1, y: location.y)
    }
}

func day3() {
    let movementDirections =
        readInputFile("day3-input")
        .characters
        .map { Direction(rawValue: String($0))! }

    let initialLocation = Location(x: 0, y: 0)
    let visitedLocations: Set<Location> = deliveryRouteFrom(initialLocation,
        directions: movementDirections)

    let visitedLocationsCount = visitedLocations.count
    print("answer (part I): \(visitedLocationsCount)")
    assert(visitedLocationsCount == 2592)

    let santaDirections = movementDirections.filterWithIndex { $1 % 2 == 0 }
    let roboSantaDirections = movementDirections.filterWithIndex { $1 % 2 != 0 }

    let santasLocations = deliveryRouteFrom(initialLocation, directions: santaDirections)
    let roboSantasLocations = deliveryRouteFrom(initialLocation, directions: roboSantaDirections)

    let combinedLocationsCount = santasLocations.union(roboSantasLocations).count
    print("answer (part II): \(combinedLocationsCount)")
    assert(combinedLocationsCount == 2360)
}

func deliveryRouteFrom(initialLocation: Location, directions: [Direction]) -> Set<Location> {
    var currentLocation = initialLocation
    var visitedLocations: Set<Location> = [currentLocation]

    for direction in directions {
        let newLocation = newLocationToDirection(currentLocation, direction: direction)
        visitedLocations.insert(newLocation)
        currentLocation = newLocation
    }

    return visitedLocations
}

