//
//  DateUtils.swift
//  ToDoList_ios
//
//  Created by 中野勇貴 on 2021/03/31.
//

import UIKit

class DateUtils {
    //String→Dateに変換
    class func dateFromString(string: String, format: String) -> Date {
        let formatter: DateFormatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: format, options: 0, locale: Locale(identifier: "ja_JP"))
        return formatter.date(from: string)!
    }
    //Date→Stringに変換
    
    class func stringFromDate(date: Date, format: String) -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
}

