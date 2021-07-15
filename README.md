# Swift 5.5 Formatters

A playground to explore capabilities of the new formatting instance methods on Date and a project to test performance of old and new on device.

![Playground preview](meta/playground.png)

## Initial findings

From the data below recorded on an iPhone 12 Pro Max running iOS 15 beta 2 running the app in release, the baseline recorded the time for looping the given number of times (100000) with no operation. Making represents the time to initialize a DateFormatter (or ISO8601DateFormatter), Make&use represents the worst-case scenario of making a new DateFormatter at the point of use and discarding.

In the iOS 15 formatted section are the use performance metrics of a few formatted Date instance methods. After that are metrics for the use of DateFormatters that are cached and reused.

See `ContentView.swift` for the code that generates this output.

```
makeFormatterWithString() -> 2021-07-15T10:09:33-0400
makeFormatterWithDateTimeStyles() -> 7/15/21, 10:09 AM
makeISO8601Formatter() -> 2021-07-15T14:09:33Z
makeISO8601FormatterExtra() -> 2021-07-15T14:09:33.601Z
format() -> 7/15/2021, 10:09 AM
format2() -> Jul 15, 2021, 10:09:33 AM
format3() -> 7/15/21, 10:09 AM
formatISO() -> 2021-07-15T14:09:33.601Z

Baseline                                100000x:   0.000µs each    0.000ms total
Baseline                                100000x:   0.000µs each    0.001ms total
Baseline                                100000x:   0.000µs each    0.000ms total
Making Date                             100000x:   0.073µs each    7.347ms total
Making Date                             100000x:   0.070µs each    6.965ms total
Making Date                             100000x:   0.058µs each    5.808ms total
Making DF with string format            100000x:   0.428µs each   42.836ms total
Making DF with string format            100000x:   0.263µs each   26.343ms total
Making DF with string format            100000x:   0.272µs each   27.244ms total
Making DF with date/time styles         100000x:   0.297µs each   29.699ms total
Making DF with date/time styles         100000x:   0.307µs each   30.717ms total
Making DF with date/time styles         100000x:   0.296µs each   29.555ms total
Making ISO8601DateFormatters - plain      1000x:  58.456µs each   58.456ms total
Making ISO8601DateFormatters - plain      1000x:  58.842µs each   58.842ms total
Making ISO8601DateFormatters - plain      1000x:  59.387µs each   59.387ms total
Making ISO8601DateFormatters - extra      1000x: 118.668µs each  118.668ms total
Making ISO8601DateFormatters - extra      1000x: 117.929µs each  117.929ms total
Making ISO8601DateFormatters - extra      1000x: 118.837µs each  118.837ms total
Make&use DateFormatter - string frmt      1000x:  84.148µs each   84.148ms total
Make&use DateFormatter - string frmt      1000x:  83.976µs each   83.976ms total
Make&use DateFormatter - string frmt      1000x:  83.969µs each   83.969ms total
Make&use DateFormatter - styles           1000x:  88.153µs each   88.153ms total
Make&use DateFormatter - styles           1000x:  88.163µs each   88.163ms total
Make&use DateFormatter - styles           1000x:  88.063µs each   88.063ms total
Make&use ISO8601DateFormatter             1000x: 130.629µs each  130.629ms total
Make&use ISO8601DateFormatter             1000x: 130.641µs each  130.641ms total
Make&use ISO8601DateFormatter             1000x: 130.728µs each  130.728ms total
Make&use ISO8601DateFormatter extra       1000x: 204.051µs each  204.051ms total
Make&use ISO8601DateFormatter extra       1000x: 204.015µs each  204.015ms total
Make&use ISO8601DateFormatter extra       1000x: 204.057µs each  204.057ms total
- Cached DateFormatter
Use ISO8601DateFormatter extra          100000x:   1.966µs each  196.608ms total
Use ISO8601DateFormatter extra          100000x:   1.969µs each  196.946ms total
Use ISO8601DateFormatter extra          100000x:   1.967µs each  196.747ms total
Use DateFormatter - withString               1x: 169.039µs each    0.169ms total
Use DateFormatter - withString               1x:  18.954µs each    0.019ms total
Use DateFormatter - withString               1x:  18.001µs each    0.018ms total
Use DateFormatter - withString              10x:   2.098µs each    0.021ms total
Use DateFormatter - withString              10x:   2.110µs each    0.021ms total
Use DateFormatter - withString              10x:   2.098µs each    0.021ms total
Use DateFormatter - withString          100000x:   1.975µs each  197.480ms total
Use DateFormatter - withString          100000x:   1.969µs each  196.881ms total
Use DateFormatter - withString          100000x:   1.970µs each  196.951ms total
Use ISO8601DateFormatter                100000x:   1.740µs each  173.980ms total
Use ISO8601DateFormatter                100000x:   1.741µs each  174.093ms total
Use ISO8601DateFormatter                100000x:   1.743µs each  174.260ms total
Use ISO8601DateFormatter extra          100000x:   1.967µs each  196.652ms total
Use ISO8601DateFormatter extra          100000x:   1.966µs each  196.583ms total
Use ISO8601DateFormatter extra          100000x:   1.962µs each  196.243ms total
- iOS 15 formatters
Formatting date                         100000x:   3.415µs each  341.540ms total
Formatting date                         100000x:   3.417µs each  341.686ms total
Formatting date                         100000x:   3.413µs each  341.349ms total
date: .abbrev, time: .standard          100000x:   3.547µs each  354.685ms total
date: .abbrev, time: .standard          100000x:   3.574µs each  357.391ms total
date: .abbrev, time: .standard          100000x:   3.585µs each  358.512ms total
formatted = DF with date/time styles    100000x:   3.764µs each  376.410ms total
formatted = DF with date/time styles    100000x:   3.780µs each  378.013ms total
formatted = DF with date/time styles    100000x:   3.755µs each  375.479ms total
.iso8601 with fractional seconds        100000x:   3.467µs each  346.732ms total
.iso8601 with fractional seconds        100000x:   3.467µs each  346.719ms total
.iso8601 with fractional seconds        100000x:   3.478µs each  347.814ms total
- Manual tons of code
Make&Use DateFormatter - string format     100x:  89.990µs each    8.999ms total
Make DateFormatter - string format         100x:   0.310µs each    0.031ms total
Cached DateFormatter - string format       100x:   3.281µs each    0.328ms total
Cached DF not Date() - string format       100x:   3.140µs each    0.314ms total
```
