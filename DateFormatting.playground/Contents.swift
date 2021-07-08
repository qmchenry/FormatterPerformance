import Foundation

let date = Date()

date.formatted()
date.formatted(.dateTime) // default

date.formatted(date: .numeric, time: .omitted)
date.formatted(date: .abbreviated, time: .omitted)
date.formatted(date: .long, time: .omitted)
date.formatted(date: .complete, time: .omitted)

date.formatted(.dateTime.year().day().month())
date.formatted(.dateTime.year(.twoDigits).day().month())
date.formatted(.dateTime.year(.twoDigits).day().month(.defaultDigits))
date.formatted(.dateTime.year(.twoDigits).day(.twoDigits).month(.twoDigits))
date.formatted(.dateTime.day(.ordinalOfDayInMonth))
date.formatted(.dateTime.day(.julianModified()))
date.formatted(.dateTime.year().day().month(.wide))
date.formatted(.dateTime.year().day().month(.wide).locale(Locale(identifier: "cs")))
date.formatted(.dateTime.year().day().month(.wide).locale(Locale(identifier: "zh")))
date.formatted(.dateTime.year().day().month(.wide).locale(Locale(identifier: "hi")))
date.formatted(.dateTime.weekday(.wide))
date.formatted(.dateTime.weekday(.wide).locale(Locale(identifier: "de")))

date.formatted(.iso8601)
date.formatted(.iso8601.dateSeparator(.dash))
date.formatted(.iso8601.timeSeparator(.colon))
date.formatted(.iso8601.year().month().day().timeZone(separator: .omitted).dateSeparator(.dash).time(includingFractionalSeconds: true).timeSeparator(.colon))
date.formatted(.iso8601.year().month().day().time(includingFractionalSeconds: true))

date.formatted(date: .omitted, time: .shortened)
date.formatted(date: .omitted, time: .standard)
date.formatted(date: .omitted, time: .complete)

