//
//  Money.swift
//  JobTracker
//
//  Created by Robson Tenório on 24/07/22.
//

import Foundation


public extension Float {
    var moneyLocalized: String {
        NumberFormatter.localizedString(from: NSNumber(value: self), number: .currency)
    }
}

public extension Double {
    var moneyLocalized: String {
        NumberFormatter.localizedString(from: NSNumber(value: self), number: .currency)
    }
}

extension Date {
    var shortDate: String {
        self.formatted(Date.FormatStyle().month(.abbreviated).day(.twoDigits))
    }
    
    var year: Int {
        Int(self.formatted(.dateTime.year(.twoDigits)))!
    }
    
    var monthNumber: Int {
        Int(self.formatted(.dateTime.month(.twoDigits)))!
    }
    
    var monthName: String {
        DateFormatter().monthSymbols[self.monthNumber - 1]
    }
}
