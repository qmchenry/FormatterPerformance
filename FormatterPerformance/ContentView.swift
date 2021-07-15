//
//  ContentView.swift
//  FormatterPerformance
//
//  Created by Quinn McHenry on 7/7/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello formatted()!")
            .onAppear {
                lotsOfFormatting()
            }
    }

    @discardableResult func makeFormatterWithString() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }

    @discardableResult func makeFormatterWithDateTimeStyles() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }

    @discardableResult func makeISO8601Formatter() -> ISO8601DateFormatter {
        let formatter = ISO8601DateFormatter()
        return formatter
    }

    @discardableResult func makeISO8601FormatterExtra() -> ISO8601DateFormatter {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withFractionalSeconds, .withInternetDateTime]
        return formatter
    }

    @discardableResult func use(formatter: DateFormatter, date: Date) -> String {
        formatter.string(from: date)
    }

    @discardableResult func use(formatter: ISO8601DateFormatter, date: Date) -> String {
        formatter.string(from: date)
    }

    @available(iOS 15.0, *)
    @discardableResult func format(date: Date) -> String {
        date.formatted()
    }

    @available(iOS 15.0, *)
    @discardableResult func format2(date: Date) -> String {
        date.formatted(date: .abbreviated, time: .standard)
    }

    @available(iOS 15.0, *)
    @discardableResult func format3(date: Date) -> String {
        date.formatted(.dateTime.year(.twoDigits).day().month(.defaultDigits).hour().minute())
    }

    @available(iOS 15.0, *)
    @discardableResult func formatISO(date: Date) -> String {
        date.formatted(.iso8601.year().month().day().timeZone(separator: .omitted).dateSeparator(.dash).time(includingFractionalSeconds: true).timeSeparator(.colon))
    }

    func lotsOfFormatting() {
        let date = Date()
        print("makeFormatterWithString() -> \(use(formatter: makeFormatterWithString(), date: date))")
        print("makeFormatterWithDateTimeStyles() -> \(use(formatter: makeFormatterWithDateTimeStyles(), date: date))")
        print("makeISO8601Formatter() -> \(use(formatter: makeISO8601Formatter(), date: date))")
        print("makeISO8601FormatterExtra() -> \(use(formatter: makeISO8601FormatterExtra(), date: date))")
        if #available(iOS 15.0, *) {
            print("format() -> \(format(date: date))")
            print("format2() -> \(format2(date: date))")
            print("format3() -> \(format3(date: date))")
            print("formatISO() -> \(formatISO(date: date))")
                print()
        }

        time(name: "Baseline                            ", count: 100000) { }
        time(name: "Baseline                            ", count: 100000) { }
        time(name: "Baseline                            ", count: 100000) { }
        timeMaking(name: "Making Date                         ", count: 100000) { Date() }
        timeMaking(name: "Making Date                         ", count: 100000) { Date() }
        timeMaking(name: "Making Date                         ", count: 100000) { Date() }

        timeMaking(name: "Making DF with string format        ", count: 100000) { makeFormatterWithString() }
        timeMaking(name: "Making DF with string format        ", count: 100000) { makeFormatterWithString() }
        timeMaking(name: "Making DF with string format        ", count: 100000) { makeFormatterWithString() }
        timeMaking(name: "Making DF with date/time styles     ", count: 100000) { makeFormatterWithDateTimeStyles() }
        timeMaking(name: "Making DF with date/time styles     ", count: 100000) { makeFormatterWithDateTimeStyles() }
        timeMaking(name: "Making DF with date/time styles     ", count: 100000) { makeFormatterWithDateTimeStyles() }
        timeMaking(name: "Making ISO8601DateFormatters - plain", count: 1000) { makeISO8601Formatter() }
        timeMaking(name: "Making ISO8601DateFormatters - plain", count: 1000) { makeISO8601Formatter() }
        timeMaking(name: "Making ISO8601DateFormatters - plain", count: 1000) { makeISO8601Formatter() }
        timeMaking(name: "Making ISO8601DateFormatters - extra", count: 1000) { makeISO8601FormatterExtra() }
        timeMaking(name: "Making ISO8601DateFormatters - extra", count: 1000) { makeISO8601FormatterExtra() }
        timeMaking(name: "Making ISO8601DateFormatters - extra", count: 1000) { makeISO8601FormatterExtra() }

        time(name: "Make&use DateFormatter - string frmt", count: 1000) { use(formatter: makeFormatterWithString(), date: date) }
        time(name: "Make&use DateFormatter - string frmt", count: 1000) { use(formatter: makeFormatterWithString(), date: date) }
        time(name: "Make&use DateFormatter - string frmt", count: 1000) { use(formatter: makeFormatterWithString(), date: date) }
        time(name: "Make&use DateFormatter - styles     ", count: 1000) { use(formatter: makeFormatterWithDateTimeStyles(), date: date) }
        time(name: "Make&use DateFormatter - styles     ", count: 1000) { use(formatter: makeFormatterWithDateTimeStyles(), date: date) }
        time(name: "Make&use DateFormatter - styles     ", count: 1000) { use(formatter: makeFormatterWithDateTimeStyles(), date: date) }
        time(name: "Make&use ISO8601DateFormatter       ", count: 1000) { use(formatter: makeISO8601Formatter(), date: date) }
        time(name: "Make&use ISO8601DateFormatter       ", count: 1000) { use(formatter: makeISO8601Formatter(), date: date) }
        time(name: "Make&use ISO8601DateFormatter       ", count: 1000) { use(formatter: makeISO8601Formatter(), date: date) }
        time(name: "Make&use ISO8601DateFormatter extra ", count: 1000) { use(formatter: makeISO8601FormatterExtra(), date: date) }
        time(name: "Make&use ISO8601DateFormatter extra ", count: 1000) { use(formatter: makeISO8601FormatterExtra(), date: date) }
        time(name: "Make&use ISO8601DateFormatter extra ", count: 1000) { use(formatter: makeISO8601FormatterExtra(), date: date) }

        print("- Cached DateFormatter")
        let isoFormatterExtra = makeISO8601FormatterExtra()
        time(name: "Use ISO8601DateFormatter extra      ", count: 100000) { use(formatter: isoFormatterExtra, date: date) }
        time(name: "Use ISO8601DateFormatter extra      ", count: 100000) { use(formatter: isoFormatterExtra, date: date) }
        time(name: "Use ISO8601DateFormatter extra      ", count: 100000) { use(formatter: isoFormatterExtra, date: date) }
        let formatterWithString = makeFormatterWithString()
        time(name: "Use DateFormatter - withString      ", count: 1) { use(formatter: formatterWithString, date: date) }
        time(name: "Use DateFormatter - withString      ", count: 1) { use(formatter: formatterWithString, date: date) }
        time(name: "Use DateFormatter - withString      ", count: 1) { use(formatter: formatterWithString, date: date) }
        time(name: "Use DateFormatter - withString      ", count: 1) { use(formatter: formatterWithString, date: date) }
        time(name: "Use DateFormatter - withString      ", count: 1) { use(formatter: formatterWithString, date: date) }
        time(name: "Use DateFormatter - withString      ", count: 10) { use(formatter: formatterWithString, date: date) }
        time(name: "Use DateFormatter - withString      ", count: 10) { use(formatter: formatterWithString, date: date) }
        time(name: "Use DateFormatter - withString      ", count: 10) { use(formatter: formatterWithString, date: date) }
        time(name: "Use DateFormatter - withString      ", count: 100000) { use(formatter: formatterWithString, date: date) }
        time(name: "Use DateFormatter - withString      ", count: 100000) { use(formatter: formatterWithString, date: date) }
        time(name: "Use DateFormatter - withString      ", count: 100000) { use(formatter: formatterWithString, date: date) }
        let formatterISO8601 = makeISO8601Formatter()
        time(name: "Use ISO8601DateFormatter            ", count: 100000) { use(formatter: formatterISO8601, date: date) }
        time(name: "Use ISO8601DateFormatter            ", count: 100000) { use(formatter: formatterISO8601, date: date) }
        time(name: "Use ISO8601DateFormatter            ", count: 100000) { use(formatter: formatterISO8601, date: date) }
        let formatterISO8601Extra = makeISO8601FormatterExtra()
        time(name: "Use ISO8601DateFormatter extra      ", count: 100000) { use(formatter: formatterISO8601Extra, date: date) }
        time(name: "Use ISO8601DateFormatter extra      ", count: 100000) { use(formatter: formatterISO8601Extra, date: date) }
        time(name: "Use ISO8601DateFormatter extra      ", count: 100000) { use(formatter: formatterISO8601Extra, date: date) }

        if #available(iOS 15.0, *) {
            print("- iOS 15 formatters")
            time(name: "Formatting date                     ", count: 100000) { format(date: date) }
            time(name: "Formatting date                     ", count: 100000) { format(date: date) }
            time(name: "Formatting date                     ", count: 100000) { format(date: date) }
            time(name: "date: .abbrev, time: .standard      ", count: 100000) { format2(date: date) }
            time(name: "date: .abbrev, time: .standard      ", count: 100000) { format2(date: date) }
            time(name: "date: .abbrev, time: .standard      ", count: 100000) { format2(date: date) }
            time(name: "formatted = DF with date/time styles", count: 100000) { format3(date: date) }
            time(name: "formatted = DF with date/time styles", count: 100000) { format3(date: date) }
            time(name: "formatted = DF with date/time styles", count: 100000) { format3(date: date) }
            time(name: ".iso8601 with fractional seconds    ", count: 100000) { formatISO(date: date) }
            time(name: ".iso8601 with fractional seconds    ", count: 100000) { formatISO(date: date) }
            time(name: ".iso8601 with fractional seconds    ", count: 100000) { formatISO(date: date) }
        }

        print("- Manual tons of code")
        manualMakeAndUse()
        manualMake()
        manualUseCached()
        lotsOfManualWork4()
    }

    func time(name: String, count: Int, action: () -> Void) {
        let start = Date()
        (0..<count).forEach { _ in
            action()
        }
        let end = Date()
        let duration = end.timeIntervalSince(start)
        let msDuration = String(format: "%7.3fms", duration * 1000.0)
        let µsEach = String(format: "%7.3fµs", duration / Double(count) * 1000000)
        print("\(name) \(String(format: "%9d", count))x: \(µsEach) each  \(msDuration) total")
    }

    func timeMaking(name: String, count: Int, action: () -> Any) {
        let start = Date()
        let results = (0..<count).map { _ in
            action()
        }
        let end = Date()
        let duration = end.timeIntervalSince(start)
        let msDuration = String(format: "%7.3fms", duration * 1000.0)
        let µsEach = String(format: "%7.3fµs", duration / Double(count) * 1000000)
        print("\(name) \(String(format: "%9d", results.count))x: \(µsEach) each  \(msDuration) total")
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
