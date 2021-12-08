//
//  Day4.swift
//  adventofcode2021
//
//  Created by Dan on 2021-12-06.
//

import Foundation

struct Day4: Day {
    func part1() -> String {
        let inputFile = InputFile(fileName: "Day4", trimmingEmptyLines: false)
        let boards = processInput(input: inputFile)
        let pickOrder = inputFile.lines.first!.components(separatedBy: ",").map { Int($0)! }

        for num in pickOrder {
            for board in boards {
                board.mark(num)
                if board.isWinner {
                    return "\(board.unmarkedSum * num)"
                }
            }
        }

        fatalError()
    }

    func part2() -> String {
        let inputFile = InputFile(fileName: "Day4", trimmingEmptyLines: false)
        let boards = processInput(input: inputFile)
        let pickOrder = inputFile.lines.first!.components(separatedBy: ",").map { Int($0)! }

        var winnerIndices: [Array.Index] = []
        var finish = false
        var lastCalled = -1
        for num in pickOrder {
            for board in boards {
                board.mark(num)
                if board.isWinner {
                    //swift doesn't have ordered sets
                    if let index = boards.firstIndex(of: board), !winnerIndices.contains(index) {
                        winnerIndices.append(index)
                    }
                    if winnerIndices.count == boards.count {
                        finish = true
                        lastCalled = num
                    }
                }
            }
            if finish {
                break
            }
        }

        if !finish || lastCalled == -1 {
            fatalError("you fucked up")
        }

        return "\(boards[winnerIndices.last!].unmarkedSum * lastCalled)"
    }

    private func processInput(input: InputFile) -> [Board] {
        let boardsData = Array(input.lines[1...])

        var index = 1
        var boards: [Board] = []
        while boardsData[safe: index] != nil {
            let boardData = boardsData[index ... index+4]
                .map {
                    $0.components(separatedBy: " ")
                        .filter { $0 != "" }
                        .map { Int($0)! }
                }
            boards.append(Board(data: boardData))
            index += 6
        }

        return boards
    }
}

final class Board: Equatable {
    static func == (lhs: Board, rhs: Board) -> Bool {
        lhs.data == rhs.data
    }

    init(data: [[Int]]) {
        self.data = data
    }

    private var data: [[Int]]

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

    var isWinner: Bool {
        for r in (0 ..< data.count) {
            let rowSum = data[r].reduce(0, +)
            let colSum = (0..<5).reduce(0, { result, index in
                return result + data[index][r]
            })

            if rowSum == -5 || colSum == -5 {
                return true
            }
        }

        return false
    }

    var unmarkedSum: Int {
        data
            .flatMap { $0 }
            .filter { $0 >= 0 }
            .reduce(0, +)
    }

    func mark(_ value: Int) {
        for r in (0 ..< data.count) {
            for c in (0 ..< data[r].count) {
                if data[r][c] == value {
                    data[r][c] = -1
                }
            }
        }
    }
}
