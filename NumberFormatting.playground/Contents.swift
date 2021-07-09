import Foundation

0.45.formatted(.percent)

Double.pi.formatted(.number)
Double.pi.formatted(.number.grouping(.automatic))
Double.pi.formatted(.number.precision(.significantDigits(2)))
Double.pi.formatted(.number.precision(.integerLength(2...4)))
Double.pi.formatted(.number.precision(.fractionLength(4)))
Double.pi.formatted(.number.precision(.fractionLength(4...6)))
Double.pi.formatted(.number.precision(.integerAndFractionLength(integer: 3, fraction: 2)))

(1000 * Double.pi).formatted(.number.notation(.scientific))
(1000 * Double.pi).formatted(.number.notation(.compactName))
(1000 * Double.pi).formatted(.number.scale(1/1000))
(3.49).formatted(.number.rounded(rule: .toNearestOrEven, increment: 1))
(3.5).formatted(.number.rounded(rule: .toNearestOrEven, increment: 1))
(3.49).formatted(.number.rounded(rule: .up, increment: 1))
(3.5).formatted(.number.rounded(rule: .down, increment: 1))
(1000 * Double.pi).formatted(.number.decimalSeparator(strategy: .always))
(1234.5).formatted(.number.sign(strategy: .always(includingZero: true)))
(-1234.5).formatted(.number.sign(strategy: .always(includingZero: true)))
(0.0).formatted(.number.sign(strategy: .always(includingZero: true)))

145.78.formatted(.currency(code: "JPY"))
145.78.formatted(.currency(code: "EUR"))
145.78.formatted(.currency(code: "USD"))

999.formatted(.byteCount(style: .file, allowedUnits: .all, spellsOutZero: true, includesExactByteCount: false))
1000.formatted(.byteCount(style: .memory, allowedUnits: .all, spellsOutZero: true, includesExactByteCount: false))
1024.formatted(.byteCount(style: .file, allowedUnits: .all, spellsOutZero: true, includesExactByteCount: false))
1_048_576.formatted(.byteCount(style: .file, allowedUnits: .all, spellsOutZero: true, includesExactByteCount: false))
1_048_576.formatted(.byteCount(style: .file, allowedUnits: .bytes, spellsOutZero: true, includesExactByteCount: false))
1_048_576.formatted(.byteCount(style: .file, allowedUnits: .all, spellsOutZero: true, includesExactByteCount: false))

Measurement(value: 98.6, unit: UnitTemperature.fahrenheit)
Measurement(value: 98.6, unit: UnitTemperature.fahrenheit).formatted(.measurement())
Measurement(value: 98.6, unit: UnitTemperature.fahrenheit).formatted(.measurement(width: .narrow))
Measurement(value: 98.6, unit: UnitTemperature.fahrenheit).formatted(.measurement(width: .wide))

Measurement(value: 10, unit: UnitVolume.liters).formatted(.measurement(width: .narrow))
Measurement(value: 10, unit: UnitVolume.liters).converted(to: .imperialTeaspoons).formatted(.measurement(width: .narrow)) // oops


/*:

 How else can we use FormatStyle?

 @available(iOS 15.0, *)
 struct FormatterView: View {
     var body: some View {
         VStack {
             Text(1.35, format: formatted(.percent))
             Text(Double.pi, format: .number)
             Text(Double.pi, format: .number.precision(.significantDigits(3)))
         }
     }
 }

 */

