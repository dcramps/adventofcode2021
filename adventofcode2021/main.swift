import Foundation

let days: [Day] = [
    Day1(),
    Day2(),
    Day3(),
    Day4(),
    Day5(),
    Day6(),
]

var ticker = Ticker()
for day in days {
    ticker.start()
    let p1 = day.part1()
    print("[\(ticker.finish())] \(p1)")

    ticker.start()
    let p2 = day.part2()
    print("[\(ticker.finish())] \(p2)")
}

struct Ticker {
    private var startDate: Date!
    mutating func start() {
        startDate = Date()
    }

    func finish() -> String {
        String(format: "%.3f ms", Date().timeIntervalSince(startDate) * 1000)
    }
}
