import Foundation

extension Date {
    static func fromString(_ dateString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current
        dateFormatter.locale = .current
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:s"
        
        return dateFormatter.date(from: dateString) ?? Date()
    }
}
