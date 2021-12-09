//
//  Day2.swift
//  adventofcode2021
//
//  Created by Dan on 2021-12-06.
//

import Foundation

struct Day2: Day {
    enum Direction: String {
        case forward
        case down
        case up
    }

    func part1() -> Int {
        let input = InputFile(fileName: "Day2").lines
        var horizontal = 0
        var vertical = 0
        input.forEach { line in
            let components = line.components(separatedBy: " ")
            let value = Int(components.last!)!
            switch Direction(rawValue: components.first!) {
            case .forward:
                horizontal += value
            case .down:
                vertical += value
            case .up:
                vertical -= value
            case .none:
                break
            }
        }

        return vertical * horizontal
    }

    func part2() -> Int {
        let input = InputFile(fileName: "Day2").lines
        var horizontal = 0
        var vertical = 0
        var aim = 0
        input.forEach { line in
            let components = line.components(separatedBy: " ")
            let value = Int(components.last!)!
            switch Direction(rawValue: components.first!) {
            case .forward:
                horizontal += value
                vertical += aim * value
            case .down:
                aim += value
            case .up:
                aim -= value
            case .none:
                break
            }
        }

        return vertical * horizontal
    }
}
