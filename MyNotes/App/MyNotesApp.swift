import SwiftUI

@main
struct MyNotesApp: App {
    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
        WindowGroup {
            NotesListView()
                .environment(\.managedObjectContext,  PersistenceController.shared.container.viewContext)
        }
        .onChange(of: scenePhase) { newValue in
            PersistenceController.shared.save()
        }
    }
}
