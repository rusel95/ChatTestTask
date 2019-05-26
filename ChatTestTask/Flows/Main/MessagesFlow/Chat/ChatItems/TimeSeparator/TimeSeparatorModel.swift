//
//  TimeSeparatorModel.swift
//  ChatTestTask
//
//  Created by Ruslan Popesku on 5/26/19.
//  Copyright © 2019 Buyper. All rights reserved.
//

import Foundation
import UIKit
import Chatto

class TimeSeparatorModel: ChatItemProtocol {
    let uid: String
    let type: String = TimeSeparatorModel.chatItemType
    let date: String
    
    static var chatItemType: ChatItemType {
        return "TimeSeparatorModel"
    }
    
    init(uid: String, date: String) {
        self.date = date
        self.uid = uid
    }
}

extension Date {
    // Have a time stamp formatter to avoid keep creating new ones. This improves performance
    static let weekdayAndDateStampDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.dateFormat = "EEEE, MMM dd yyyy"
        return dateFormatter
    }()
    
    func toWeekDayAndDateString() -> String {
        return Date.weekdayAndDateStampDateFormatter.string(from: self)
    }
}
