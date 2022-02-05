import Foundation
import CoreData
import SwiftUI
import UIKit

extension Note {
 
    var date: Date {
        get {
            date_ ?? Date()
        } set {
            date_ = newValue
        }
        
    }

    var dateString: String {
        let dateFormatter = initDateFormatter()
        
        return dateFormatter.string(from: date)
    }
    
    var backgroundColorHex: String {
        get {
            backgroundColorHex_ ?? Constants.blackHex
        } set {
            backgroundColorHex_ = newValue
        }
    }
    
    var textColorHex: String {
        get {
            textColorHex_ ?? Constants.whiteHex
        } set {
            textColorHex_ = newValue
        }
    }
    
    var noteText: String {
        get {
            noteText_ ?? "Empty note"
        } set {
            noteText_ = newValue
        }
    }
    
    var backgroundColor: Color {
        get {
            Color(hex: backgroundColorHex)
        } set {
            backgroundColorHex_ = UIColor(newValue).toHexString()
        }
    }
    
    var textColor: Color {
        get {
            Color(hex: textColorHex)
        } set {
            textColorHex_ = UIColor(newValue).toHexString()
        }
    }
    
    static func delete(at offset: IndexSet, for notes: [Note]) {
        if let first = notes.first, let viewContext = first.managedObjectContext {
            offset.map { notes[$0] }.forEach(viewContext.delete)
        }
        
        PersistenceController.shared.save()
    }
    
    static func fetch() -> NSFetchRequest<Note> {
        let request = NSFetchRequest<Note>(entityName: "Note")
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Note.date_, ascending: false)]
        request.predicate = NSPredicate(format: "TRUEPREDICATE")
        
        return request
    }
    
    private func initDateFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        
        dateFormatter.timeZone = .current
        dateFormatter.locale = .current
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:s"
        
        return dateFormatter
    }
}
