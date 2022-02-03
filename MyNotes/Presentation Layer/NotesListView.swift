import SwiftUI
import CoreData

struct NotesListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(fetchRequest: Note.fetch())
    private var notes: FetchedResults<Note>

    
    var body: some View {
        NavigationView {
            List {
                ForEach(notes) { note in
                    NoteView(note: note)
                        .environmentObject(note)
                }
                .onDelete { indexSet in
                    Note.delete(at: indexSet, for: Array(notes))
                }
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
