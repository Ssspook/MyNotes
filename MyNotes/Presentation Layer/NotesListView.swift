import SwiftUI

struct NotesListView: View {
    @StateObject private var coreDataService = CoreDataService()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(coreDataService.notes) { note in
                    NoteView(note: note, coreDataService)
                }
                .onDelete(perform: coreDataService.deleteNote)
            }
            .navigationTitle(Text("Notes"))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        CreateNoteView()
                    } label: {
                        Image(systemName: "plus")
                            .font(.system(size: Constants.buttonFont))
                            .foregroundColor(.indigo)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NotesListView()
    }
}
