import Foundation

struct InputFile {
    init(fileName: String, trimmingEmptyLines: Bool = true) {
        let fm = FileManager()
        let home = fm.homeDirectoryForCurrentUser
        let filePath = home.appendingPathComponent("workspace/adventofcode2021/adventofcode2021/inputs/\(fileName).txt")

        do {
            let data = try String(contentsOfFile: filePath.path, encoding: .utf8)
            var  lines = data.components(separatedBy: .newlines)
            if trimmingEmptyLines {
                lines = lines.filter { $0 != "" }
            }

            self.lines = lines
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    let lines: [String]
}

extension Array {
    subscript(safe index: Int) -> Element? {
        guard index > 0 && index < count else {
            return nil
        }

        return self[index]
    }
}
