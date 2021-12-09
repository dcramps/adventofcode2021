import Foundation

struct Day1: Day {
    func part1() -> Int {
        let input = InputFile(fileName: "Day1").lines.map { Int($0)! }
        let increases = _part1(input: input)
        return increases
    }

    func _part1(input: [Int]) -> Int {
        var increases = 0
        for index in (1 ..< input.count) {
            if input[index] > input[index-1] {
                increases += 1
            }
        }

        return increases
    }

    func part2() -> Int {
        let input = InputFile(fileName: "Day1").lines.map { Int($0)! }

        let windows = (0 ..< input.count).compactMap { index -> Int? in
            guard index+3 <= input.count else {
                return nil
            }

            return input[index ..< index+3].reduce(0, +)
        }

        let increases = _part1(input: windows)
        return increases
    }
}
