//
//  AppFormatter.swift
//  Core
//
//  Created by Ruslan Popesku on 5/26/19.
//  Copyright © 2019 Buyper. All rights reserved.
//

import Foundation

public struct AppFormatter {
    
    public struct Date {
        
        static let iso: DateFormatter = {
            let formatter = DateFormatter()
            formatter.calendar = Calendar(identifier: .iso8601)
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
            return formatter
        }()
        
        static let serverDate: DateFormatter = {
            let formatter = DateFormatter()
            let enUSPosixLocale = Locale(identifier: "en_US_POSIX")
            formatter.locale = enUSPosixLocale
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
            return formatter
        }()
        
        public static let serverYearMonthDay: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "YYYY-MM-dd"
            return formatter
        }()
        
        public static let dayMonth: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "d MMM"
            return formatter
        }()
        
        public static let year: DateFormatter = {
            let formatter = DateFormatter()
            formatter.timeZone = TimeZone(secondsFromGMT: 0)!
            formatter.dateFormat = "yyyy"
            return formatter
        }()
        
        public static let timeFrame: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            return formatter
        }()
        
        public static let calendarMonth: DateFormatter = {
            let format = "MMMM"
            let formatter = DateFormatter()
            formatter.dateFormat = format
            return formatter
        }()
        
        public static let monthYear: DateFormatter = {
            let format = "MMMM yyyy"
            let formatter = DateFormatter()
            formatter.dateFormat = format
            formatter.locale = Locale(identifier: "en_US_POSIX")
            return formatter
        }()
        
        public static let monthYearWithBlankSpace: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMMM   yyyy"
            return formatter
        }()
        
        public static let dayMonthYear: DateFormatter = {
            let format = "d MMMM yyyy"
            let formatter = DateFormatter()
            formatter.dateFormat = format
            return formatter
        }()
        
        public static let dayMonthTime: DateFormatter = {
            let formatter = DateFormatter()
            formatter.amSymbol = "am"
            formatter.pmSymbol = "pm"
            formatter.dateFormat = "d MMM 'at' h:mm a"
            return formatter
        }()
        
        public static let time: DateFormatter = {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.amSymbol = "am"
            formatter.pmSymbol = "pm"
            formatter.dateFormat = "h:mm a"
            return formatter
        }()
        
        public static let month: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMMM"
            formatter.locale = Locale(identifier: "en_US_POSIX")
            return formatter
        }()
        
        public static let fullDate: DateFormatter = {
            let formatter = DateFormatter()
            formatter.amSymbol = "am"
            formatter.pmSymbol = "pm"
            formatter.dateFormat = "d MMM yyyy, h:mm a"
            return formatter
        }()
        
    }
}
