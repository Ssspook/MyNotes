import Foundation
import CoreData

class CoreDataService: ObservableObject {
    let container: NSPersistentContainer
    @Published var notes: [Note] = []
    
    init() {
        container = NSPersistentContainer(name: "MyNotes")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error loading core data \(error)")
            }
        }
        
        fetchNotes()
    }
    
    func fetchNotes() {
        let request = NSFetchRequest<Note>(entityName: "Note")
        
        do {
            notes = try container.viewContext.fetch(request)
        } catch let error {
            print("Error \(error)")
        }
    }
    
    func addNote(_ noteProperties: NoteProperties) {
        let note = Note(context: container.viewContext)
        
        note.noteText = noteProperties.text
        note.date = noteProperties.dateOfCreation
        note.textColorHex = noteProperties.textColorHex
        note.backgroundColorHex = noteProperties.backgroundColorHex
        
        saveData()
    }
    
    func deleteNote(by index: IndexSet) {
        guard let index = index.first else { return }
        let noteToDelete = notes[index]
        
        container.viewContext.delete(noteToDelete)
        saveData()
    }
    
    func updateNote(_ noteToUpdate: Note, with newProperties: NoteProperties) {
        noteToUpdate.noteText = newProperties.text
        noteToUpdate.backgroundColorHex = newProperties.backgroundColorHex
        noteToUpdate.textColorHex = noteToUpdate.textColorHex
        noteToUpdate.date = newProperties.dateOfCreation
        
        saveData()
    }
    
    func saveData() {
        try? container.viewContext.save()
    }
}
