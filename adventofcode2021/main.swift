import Foundation

let days: [Day] = [
    Day1(),
    Day2(),
    Day3(),
    Day4(),
    Day5(),
]
for day in days {
    print(day.part1())
    print(day.part2())
}
