# Swift 5.5 Formatters

A playground to explore capabilities of the new formatting instance methods on Date and a project to test performance of old and new on device.

![Playground preview](meta/playground.png)

## Initial findings

From the data below recorded on an iPhone 12 Pro Max running iOS 15 beta 2 running the app in release, the baseline recorded the time for looping the given number of times (100000) with no operation. Making represents the time to initialize a DateFormatter (or ISO8601DateFormatter), Make&use represents the worst-case scenario of making a new DateFormatter at the point of use and discarding.

In the iOS 15 formatted section are the use performance metrics of a few formatted Date instance methods. After that are metrics for the use of DateFormatters that are cached and reused.

See `ContentView.swift` for the code that generates this output.

```
makeFormatterWithString() -> 2021-07-15T10:23:09-0400
makeFormatterWithDateTimeStyles() -> 7/15/21, 10:23 AM
makeISO8601Formatter() -> 2021-07-15T14:23:09Z
makeISO8601FormatterExtra() -> 2021-07-15T14:23:09.067Z
format() -> 7/15/2021, 10:23 AM
format2() -> Jul 15, 2021, 10:23:09 AM
format3() -> 7/15/21, 10:23 AM
formatISO() -> 2021-07-15T14:23:09.067Z

Baseline                                100000x:   0.000µs each    0.000ms total
Baseline                                100000x:   0.000µs each    0.000ms total
Baseline                                100000x:   0.000µs each    0.001ms total
Making Date                             100000x:   0.047µs each    4.684ms total
Making Date                             100000x:   0.034µs each    3.403ms total
Making Date                             100000x:   0.034µs each    3.405ms total
Making DF with string format            100000x:   0.375µs each   37.509ms total
Making DF with string format            100000x:   0.264µs each   26.397ms total
Making DF with string format            100000x:   0.272µs each   27.196ms total
Making DF with date/time styles         100000x:   0.297µs each   29.691ms total
Making DF with date/time styles         100000x:   0.307µs each   30.652ms total
Making DF with date/time styles         100000x:   0.296µs each   29.603ms total
Making ISO8601DateFormatters - plain      1000x:  58.615µs each   58.615ms total
Making ISO8601DateFormatters - plain      1000x:  59.185µs each   59.185ms total
Making ISO8601DateFormatters - plain      1000x:  59.888µs each   59.888ms total
Making ISO8601DateFormatters - extra      1000x: 117.772µs each  117.772ms total
Making ISO8601DateFormatters - extra      1000x: 117.699µs each  117.699ms total
Making ISO8601DateFormatters - extra      1000x: 117.321µs each  117.321ms total
Make&use DateFormatter - string frmt      1000x:  84.221µs each   84.221ms total
Make&use DateFormatter - string frmt      1000x:  84.056µs each   84.056ms total
Make&use DateFormatter - string frmt      1000x:  84.053µs each   84.053ms total
Make&use DateFormatter - styles           1000x:  88.121µs each   88.121ms total
Make&use DateFormatter - styles           1000x:  88.109µs each   88.109ms total
Make&use DateFormatter - styles           1000x:  88.159µs each   88.159ms total
Make&use ISO8601DateFormatter             1000x: 130.782µs each  130.782ms total
Make&use ISO8601DateFormatter             1000x: 130.698µs each  130.698ms total
Make&use ISO8601DateFormatter             1000x: 130.690µs each  130.690ms total
Make&use ISO8601DateFormatter extra       1000x: 204.044µs each  204.044ms total
Make&use ISO8601DateFormatter extra       1000x: 203.805µs each  203.805ms total
Make&use ISO8601DateFormatter extra       1000x: 203.922µs each  203.922ms total
- Cached DateFormatter
Use ISO8601DateFormatter extra          100000x:   1.963µs each  196.327ms total
Use ISO8601DateFormatter extra          100000x:   1.968µs each  196.846ms total
Use ISO8601DateFormatter extra          100000x:   1.962µs each  196.201ms total
Use DateFormatter - withString               1x: 180.006µs each    0.180ms total
Use DateFormatter - withString               1x:  19.073µs each    0.019ms total
Use DateFormatter - withString               1x:  17.047µs each    0.017ms total
Use DateFormatter - withString               1x:   2.980µs each    0.003ms total
Use DateFormatter - withString               1x:   2.027µs each    0.002ms total
Use DateFormatter - withString              10x:   2.003µs each    0.020ms total
Use DateFormatter - withString              10x:   1.991µs each    0.020ms total
Use DateFormatter - withString              10x:   2.003µs each    0.020ms total
Use DateFormatter - withString          100000x:   1.969µs each  196.887ms total
Use DateFormatter - withString          100000x:   1.963µs each  196.304ms total
Use DateFormatter - withString          100000x:   1.966µs each  196.564ms total
Use ISO8601DateFormatter                100000x:   1.738µs each  173.829ms total
Use ISO8601DateFormatter                100000x:   1.739µs each  173.931ms total
Use ISO8601DateFormatter                100000x:   1.744µs each  174.375ms total
Use ISO8601DateFormatter extra          100000x:   1.962µs each  196.161ms total
Use ISO8601DateFormatter extra          100000x:   1.965µs each  196.535ms total
Use ISO8601DateFormatter extra          100000x:   1.960µs each  195.973ms total
- iOS 15 formatters
Formatting date                         100000x:   3.423µs each  342.298ms total
Formatting date                         100000x:   3.419µs each  341.858ms total
Formatting date                         100000x:   3.413µs each  341.332ms total
date: .abbrev, time: .standard          100000x:   3.629µs each  362.941ms total
date: .abbrev, time: .standard          100000x:   3.690µs each  368.957ms total
date: .abbrev, time: .standard          100000x:   3.678µs each  367.839ms total
formatted = DF with date/time styles    100000x:   3.741µs each  374.097ms total
formatted = DF with date/time styles    100000x:   3.757µs each  375.729ms total
formatted = DF with date/time styles    100000x:   3.765µs each  376.540ms total
.iso8601 with fractional seconds        100000x:   3.487µs each  348.659ms total
.iso8601 with fractional seconds        100000x:   3.481µs each  348.129ms total
.iso8601 with fractional seconds        100000x:   3.484µs each  348.362ms total
- Manual tons of code
Make&Use DateFormatter - string format     100x:  93.601µs each    9.360ms total
Make DateFormatter - string format         100x:   0.300µs each    0.030ms total
Cached DateFormatter - string format       100x:   3.260µs each    0.326ms total
Cached DF not Date() - string format       100x:   3.140µs each    0.314ms total
```
