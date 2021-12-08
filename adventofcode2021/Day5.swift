//
//  Day5.swift
//  adventofcode2021
//
//  Created by Dan on 2021-12-07.
//

import Foundation

struct Day5: Day {
    func part1() -> String {
        let inputData = makeIntArray(inputFile: InputFile(fileName: "Day5"))
        var grid = Grid(inputData: inputData)
        markPart1(inputData: inputData, grid: &grid)
        return grid.count
    }

    private func markPart1(inputData: [[Int]], grid: inout Grid) {
        for line in inputData {
            if line[0] == line[2] {
                (min(line[1], line[3])...max(line[1], line[3])).forEach { x in
                    grid.mark(r: x, c: line[0])
                }
            }
            if line[1] == line[3] {
                (min(line[0], line[2])...max(line[0], line[2])).forEach { x in
                    grid.mark(r: line[1], c: x)
                }
            }
        }
    }

    func part2() -> String {
        let inputData = makeIntArray(inputFile: InputFile(fileName: "Day5"))
        var grid = Grid(inputData: inputData)

        for line in inputData {
            var xVals: [Int] = []
            var yVals: [Int] = []
            let xStride = line[0] < line[2] ? 1 : -1
            let yStride = line[1] < line[3] ? 1 : -1
            for x in stride(from: line[0], to: line[2] + xStride, by: xStride) {
                xVals.append(x)
            }
            for y in stride(from: line[1], to: line[3] + yStride, by: yStride) {
                yVals.append(y)
            }

            // a dot isn't a line
            guard xVals.count > 1, yVals.count > 1 else {
                continue
            }

            zip(xVals, yVals).forEach { x, y in
                grid.mark(r: y, c: x)
            }
        }

        markPart1(inputData: inputData, grid: &grid)

        return grid.count
    }

    private func makeIntArray(inputFile: InputFile) -> [[Int]] {
        inputFile
            .lines
            .map { line in
                line.components(separatedBy: "->")
                    .joined(separator: ",")
                    .replacingOccurrences(of: " ", with: "")
                    .components(separatedBy: ",")
            }.map { $0.map { Int(String($0))! } }
    }

}


final class Grid {
    init(inputData: [[Int]]) {
        var minX = Int.max
        var maxX = Int.min
        var minY = Int.max
        var maxY = Int.min

        //  0  1  2  3
        // (x1,y1 x2,y2)
        for line in inputData {
            minX = min(min(minX, line[0]), line[2])
            maxX = max(max(maxX, line[0]), line[2])

            minY = min(min(minY, line[1]), line[3])
            maxY = max(max(maxY, line[1]), line[3])
        }

        data = Array(repeating: Array(repeating: ".", count: maxX + 1), count: maxY + 1)
    }

    private var data: [[Character]]
    var count: String {
        var count = 0
        for row in data {
            for character in row {
                if character == "2" || character == "3" {
                    count += 1
                }
            }
        }

        return "\(count)"
    }

    var stringValue: String {
        var output = ""
        for r in (0 ..< data.count) {
            for c in (0 ..< data[r].count) {
                output.append("\(data[r][c]) ")
            }
            output.append("\n")
        }

        return output
    }

    func mark(r: Int, c: Int) {
        if data[r][c] == "." {
            data[r][c] = "1"
        } else if data[r][c] == "1" {
            data[r][c] = "2"
        } else if data[r][c] == "2" {
            data[r][c] = "3"
        }
    }
}
