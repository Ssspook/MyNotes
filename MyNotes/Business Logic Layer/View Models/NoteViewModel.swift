import Foundation
import SwiftUI

class NoteViewModel: ObservableObject, Identifiable {
    @Published var text: String
    @Published var noteBackgroundColor: Color = .black
    @Published var creationDate: Date
    @Published var foregroundColor: Color = .white
    
    let id = UUID()
    
    var date: String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.timeZone = .current
        dateFormatter.locale = .current
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:s"
        
        return dateFormatter.string(from: creationDate)
    }
    
    init(noteText: String, date: Date) {
        text = noteText
        creationDate = date
    }
    
    func setNoteBackgroundColor(_ color: Color) {
        noteBackgroundColor = color
    }
    
    func editNote(newText: String) {
        text = newText
    }
    
    func setForegroundColor(_ foregroundColor: Color) {
        self.foregroundColor = foregroundColor
    }
}
