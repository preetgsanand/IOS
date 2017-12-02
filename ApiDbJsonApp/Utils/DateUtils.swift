import Foundation

func dateToReadableFormat(date : Date) -> String{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM dd, yyyy"
    return dateFormatter.string(from : date)
}


func dateToReadableDateTime(date : Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM dd, yyyy h:mm a"
    dateFormatter.amSymbol = "AM"
    dateFormatter.pmSymbol = "PM"
    return dateFormatter.string(from : date)
}


func dateToReadableTime(date : Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "h:mm a"
    dateFormatter.amSymbol = "AM"
    dateFormatter.pmSymbol = "PM"
    return dateFormatter.string(from : date)
}

func stringToDate(dateString : String) ->  Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    return dateFormatter.date(from: dateString) ?? Date()
}
