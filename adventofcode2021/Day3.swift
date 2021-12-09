//
//  Day3.swift
//  adventofcode2021
//
//  Created by Dan on 2021-12-06.
//

import Foundation

struct Day3: Day {
    func part1() -> Int {
        let input = InputFile(fileName: "Day3")
            .lines
            .map { Array($0) }

        var gamma: [Int] = []
        var epsilon: [Int] = []
        _part1(input: input, mostCommon: { gamma.append($0) }, leastCommon: { epsilon.append($0) })

        return gamma.fromBinaryInt * epsilon.fromBinaryInt
    }

    private func _part1(input: [[String.Element]], mostCommon: (Int) -> Void, leastCommon: (Int) -> Void) {
        for index in (0..<input.first!.count) {
            var ones = 0
            var zeros = 0
            input.forEach { array in
                if array[index] == "0" {
                    zeros += 1
                } else {
                    ones += 1
                }
            }

            mostCommon(ones > zeros ? 1 : 0)
            leastCommon(ones > zeros ? 0 : 1)
        }
    }

    func part2() -> Int {
        let input = InputFile(fileName: "Day3")
            .lines
            .map { Array($0) }

        let oxygenGeneratorRating = _part2(input: input, criteria: { $0 >= $1 }).compactMap { Int(String($0)) }.fromBinaryInt
        let co2ScrubberRating = _part2(input: input, criteria: { $0 < $1 }).compactMap { Int(String($0)) }.fromBinaryInt

        return oxygenGeneratorRating * co2ScrubberRating

    }

    private func _part2(input: [[String.Element]], criteria: ((Int, Int) -> Bool)) -> [String.Element] {
        var remaining = input
        var index = 0

        while remaining.count > 1 {
            var b1: [[String.Element]] = []
            var b2: [[String.Element]] = []

            for line in remaining {
                if line[index] == "1" {
                    b1.append(line)
                } else {
                    b2.append(line)
                }
            }

            if criteria(b1.count, b2.count) {
                remaining = b1
            } else {
                remaining = b2
            }
            index += 1
        }

        return remaining[0]
    }
}

extension Array where Element == Int {
    var fromBinaryInt: Int {
        var result: Int = 0
        for digit in self {
            if digit == 0 {
                result = result * 2
            } else {
                result = result * 2 + 1
            }
        }
        return result
    }
}
