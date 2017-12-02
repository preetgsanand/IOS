import Foundation

class DateUtils {
    static func dateToReadableFormat(date : Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        return dateFormatter.string(from : date)
    }
    
    
    static func dateToReadableDateTime(date : Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy h:mm a"
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        return dateFormatter.string(from : date)
    }
    
    
    static func dateToReadableTime(date : Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        return dateFormatter.string(from : date)
    }
    
    static func stringToDate(dateString : String) ->  Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: dateString) ?? Date()
    }
    
    static func dateToReadableYear(date : Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from : date)
    }
}


