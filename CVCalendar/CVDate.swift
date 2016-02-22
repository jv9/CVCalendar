//
//  CVDate.swift
//  CVCalendar
//
//  Created by Мак-ПК on 12/31/14.
//  Copyright (c) 2014 GameApp. All rights reserved.
//

import UIKit

public final class CVDate: NSObject {
    private let date: NSDate
    
    public let year: Int
    public let month: Int
    public let week: Int
    public let day: Int
    
   public init(date: NSDate) {
        self.date = date
        self.year = date.year.value()
        self.month = date.month.value()
        self.week = date.week.value()
        self.day = date.day.value()
        
        super.init()
    }
    
    public init(day: Int, month: Int, week: Int, year: Int) {
        if let date = Manager.dateFromYear(year, month: month, week: week, day: day) {
            self.date = date
        } else {
            self.date = NSDate()
        }
        
        self.year = year
        self.month = month
        self.week = week
        self.day = day
        
        super.init()
    }
}

extension CVDate {
    public func convertedDate() -> NSDate? {
        let calendar = NSCalendar.currentCalendar()
        let comps = Manager.componentsForDate(NSDate())
        
        comps.year = year
        comps.month = month
        comps.weekOfMonth = week
        comps.day = day
        
        return calendar.dateFromComponents(comps)
    }
}

extension CVDate {
    public var globalDescription: String {
        let month = dateFormattedStringWithFormat("MMMM", fromDate: date)
        
        return "\(month), \(year)"
    }
    
    public var commonDescription: String {
        let month = dateFormattedStringWithFormat("MMMM", fromDate: date)
        
        return "\(day) \(month), \(year)"
    }
}

private extension CVDate {
    func dateFormattedStringWithFormat(format: String, fromDate date: NSDate) -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = format
        return formatter.stringFromDate(date)
    }
}

public func ==(lhs: CVDate, rhs: CVDate) -> Bool {
    return lhs.year == rhs.year && lhs.month == rhs.month && lhs.day == rhs.day
}

public func !=(lhs: CVDate, rhs: CVDate) -> Bool {
    return !(lhs == rhs)
}
