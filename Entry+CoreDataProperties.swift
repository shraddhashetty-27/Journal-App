//
//  Entry+CoreDataProperties.swift
//  JournalApp
//
//  Created by Shraddha Shetty on 8/10/22.
//  Copyright © 2022 Shraddha Shetty. All rights reserved.
//
//

import Foundation
import CoreData


extension Entry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entry> {
        return NSFetchRequest<Entry>(entityName: "Entry")
    }

    @NSManaged public var text: String?
    @NSManaged public var date: Date?

}

extension Entry{
    func month() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat="MMM"
        if let dateToBeFormatted=date{
            let month=formatter.string(from: dateToBeFormatted)
            return month.uppercased()
            
        }
        return ""
    }
    func day() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat="d"
        if let dateToBeFormatted=date{
            let day=formatter.string(from: dateToBeFormatted)
            return day
            
        }
        return ""
    }
    
}

