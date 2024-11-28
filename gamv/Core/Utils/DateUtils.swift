//
//  DateUtils.swift
//  gamv
//
//  Created by Ajie DR on 17/11/24.
//

import Foundation

final class DateUtils: NSObject {
    static let DEFAULT_SERVER_DATE_FORMAT = "yyyy-dd-MM"
    static let LIST_DATE_FORMAT = "yyyy, dd MMM"
    
    static func convertStringDate(date: String, inputFormat: String, outputFormat: String) -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = inputFormat
        
        let date = dateFormatter.date(from: date)
        
        dateFormatter.dateFormat = outputFormat
        
        let resultString = dateFormatter.string(from: date!)
        
        return resultString
    }
}
