import SwiftUI

@main
struct MyNotesApp: App {
   @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            NotesListView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
