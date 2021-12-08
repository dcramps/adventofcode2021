//
//  Day5.swift
//  adventofcode2021
//
//  Created by Dan on 2021-12-07.
//

import Foundation

struct Day5: Day {
    func part1() -> String {
        let input = InputFile(fileName: "Day5")
            .lines
            .map { line in
                line.components(separatedBy: "->")
                    .joined(separator: ",")
                    .replacingOccurrences(of: " ", with: "")
                    .components(separatedBy: ",")
            }

        return ""
    }

    func part2() -> String {
        return ""
    }
}
