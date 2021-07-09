//
//  FormatterView.swift
//  FormatterPerformance
//
//  Created by Quinn McHenry on 7/8/21.
//

import SwiftUI

@available(iOS 15.0, *)
struct FormatterView: View {
    var body: some View {
        VStack {
            Text(1.35, format: .percent)
            Text(Double.pi, format: .number)
            Text(Double.pi, format: .number.precision(.significantDigits(3)))
        }
    }
}

@available(iOS 15.0, *)
struct FormatterView_Previews: PreviewProvider {
    static var previews: some View {
        FormatterView()
    }
}
