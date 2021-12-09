//
//  Day6.swift
//  adventofcode2021
//
//  Created by Dan on 2021-12-08.
//

import Foundation

struct Day6: Day {
    func part1() -> Int {
        var input = InputFile(fileName: "Day6").lines.first!.components(separatedBy: ",").map { Int($0)! }

        var days = 80
        while days != 0 {
            var n: [Int] = []
            for x in 0..<input.count {
                if input[x] == 0 {
                    input[x] = 6
                    n.append(8)
                } else {
                    input[x] = input[x] - 1
                }
            }
            input.append(contentsOf: n)
            n = []
            days -= 1
        }
        return input.count
    }

    func part2() -> Int {
        let input = InputFile(fileName: "Day6").lines.first!.components(separatedBy: ",").map { Int($0)! }

        // fill
        var map: [Int: Int] = [0: 0, 1: 0, 2: 0, 3: 0, 4: 0, 5: 0, 6: 0, 7: 0, 8: 0]
        for n in input {
            map[n] = map[n]! + 1
        }

        // iterate
        var days = 256
        while days != 0 {
            var map2 = map
            var x = 0
            for k in map.keys.sorted().reversed() {
                let v = map[k]!
                if k == 0 {
                    map2[6] = map2[6]! + v
                    x += v
                } else {
                    map2[k-1] = v
                }
            }
            map2[8] = x
            map = map2
            days -= 1
        }
        return map.values.reduce(0, +)
    }

    private func printDictSorted(_ dict: [Int: Int]) -> String {
        var output: String = ""
        for key in dict.keys.sorted() {
            output.append("\(key): \(dict[key]!)\n")
        }
        return output
    }
}
