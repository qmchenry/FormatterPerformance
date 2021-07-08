# Swift 5.5 Formatters

A playground to explore capabilities of the new formatting instance methods on Date and a project to test performance of old and new on device.

![Playground preview](meta/playground.png)

## Initial findings

From the data below recorded on an iPhone 12 Pro Max running iOS 15 beta 2 running the app in release, the baseline recorded the time for looping the given number of times (100000) with no operation. Making represents the time to initialize a DateFormatter (or ISO8601DateFormatter), Make&use represents the worst-case scenario of making a new DateFormatter at the point of use and discarding.

In the iOS 15 formatted section are the use performance metrics of a few formatted Date instance methods. After that are metrics for the use of DateFormatters that are cached and reused.

See `ContentView.swift` for the code that generates this output.

```
makeFormatterWithString() -> 2021-07-08T11:41:04-0400
makeFormatterWithDateTimeStyles() -> 7/8/21, 11:41 AM
makeISO8601Formatter() -> 2021-07-08T15:41:04Z
makeISO8601FormatterExtra() -> 2021-07-08T15:41:04.697Z
format() -> 7/8/2021, 11:41 AM
format2() -> Jul 8, 2021, 11:41:04 AM
format3() -> 7/8/21, 11:41 AM
formatISO() -> 2021-07-08T15:41:04.697Z

Baseline                                100000x:   0.000µs each    0.000ms total
Baseline                                100000x:   0.000µs each    0.000ms total
Baseline                                100000x:   0.000µs each    0.000ms total
Making DF with string format            100000x:   0.363µs each   36.311ms total
Making DF with string format            100000x:   0.358µs each   35.761ms total
Making DF with string format            100000x:   0.354µs each   35.444ms total
Making DF with date/time styles         100000x:   0.378µs each   37.805ms total
Making DF with date/time styles         100000x:   0.377µs each   37.689ms total
Making DF with date/time styles         100000x:   0.377µs each   37.734ms total
Making ISO8601DateFormatters - plain      1000x:  55.862µs each   55.862ms total
Making ISO8601DateFormatters - plain      1000x:  55.642µs each   55.642ms total
Making ISO8601DateFormatters - plain      1000x:  55.645µs each   55.645ms total
Making ISO8601DateFormatters - extra      1000x: 111.202µs each  111.202ms total
Making ISO8601DateFormatters - extra      1000x: 111.108µs each  111.108ms total
Making ISO8601DateFormatters - extra      1000x: 110.935µs each  110.935ms total
Make&use DateFormatter - string frmt      1000x:  83.741µs each   83.741ms total
Make&use DateFormatter - string frmt      1000x:  83.710µs each   83.710ms total
Make&use DateFormatter - string frmt      1000x:  83.629µs each   83.629ms total
Make&use DateFormatter - styles           1000x:  87.860µs each   87.860ms total
Make&use DateFormatter - styles           1000x:  87.807µs each   87.807ms total
Make&use DateFormatter - styles           1000x:  87.782µs each   87.782ms total
Make&use ISO8601DateFormatter             1000x: 129.761µs each  129.761ms total
Make&use ISO8601DateFormatter             1000x: 129.734µs each  129.734ms total
Make&use ISO8601DateFormatter             1000x: 129.649µs each  129.649ms total
Make&use ISO8601DateFormatter extra       1000x: 201.979µs each  201.979ms total
Make&use ISO8601DateFormatter extra       1000x: 201.944µs each  201.944ms total
Make&use ISO8601DateFormatter extra       1000x: 201.945µs each  201.945ms total
iOS 15 formatters
Formatting date                         100000x:   3.406µs each  340.570ms total
Formatting date                         100000x:   3.406µs each  340.624ms total
Formatting date                         100000x:   3.410µs each  340.989ms total
date: .abbrev, time: .standard          100000x:   3.501µs each  350.062ms total
date: .abbrev, time: .standard          100000x:   3.492µs each  349.175ms total
date: .abbrev, time: .standard          100000x:   3.507µs each  350.682ms total
formatted = DF with date/time styles    100000x:   3.653µs each  365.261ms total
formatted = DF with date/time styles    100000x:   3.644µs each  364.358ms total
formatted = DF with date/time styles    100000x:   3.656µs each  365.634ms total
.iso8601 with fractional seconds        100000x:   3.425µs each  342.499ms total
.iso8601 with fractional seconds        100000x:   3.417µs each  341.654ms total
.iso8601 with fractional seconds        100000x:   3.419µs each  341.904ms total
Cached DateFormatter
Use ISO8601DateFormatter extra          100000x:   2.002µs each  200.227ms total
Use ISO8601DateFormatter extra          100000x:   2.004µs each  200.397ms total
Use ISO8601DateFormatter extra          100000x:   2.003µs each  200.296ms total
Use DateFormatter - withString          100000x:   1.995µs each  199.545ms total
Use DateFormatter - withString          100000x:   2.034µs each  203.375ms total
Use DateFormatter - withString          100000x:   2.031µs each  203.131ms total
```

