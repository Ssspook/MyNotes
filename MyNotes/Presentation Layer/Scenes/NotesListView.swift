import SwiftUI
import CoreData

struct NotesListView: View {
    @FetchRequest(fetchRequest: Note.fetch())
    private var notes: FetchedResults<Note>
    @State private var redraw = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(notes) { note in
                    NoteView(note: note)
                }
                .onDelete { indexSet in
                    Note.delete(at: indexSet, for: Array(notes))
                }
            }
            .onAppear {
                redraw.toggle()
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
