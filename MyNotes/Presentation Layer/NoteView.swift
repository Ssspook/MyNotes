import SwiftUI

struct NoteView: View {
    @State private var coreDataNote: Note
    
    init(note: Note) {
        _coreDataNote = State(wrappedValue: note)
    }
    
    var body: some View {
        VStack {
            Text(coreDataNote.noteText)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .lineLimit(Constants.lineLimit)
                .foregroundColor(coreDataNote.textColor)
            
            Divider().background(.black)
            
            HStack {
                Text(coreDataNote.dateString)
                    .foregroundColor(coreDataNote.textColor)
                    .font(.system(size: Constants.dateFontSize))
                
                Spacer()
                
                NavigationLink {
                    NoteEditingView(note: coreDataNote)
                } label: {
                    EmptyView()
                }
                .opacity(0.0)
                .buttonStyle(PlainButtonStyle())
            
            }
        }
        .padding()
        .background(coreDataNote.backgroundColor)
        .cornerRadius(Constants.cornerRadius)
            
    }
}

struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        NoteView(note: Note(context: PersistenceController.preview.container.viewContext))
    }
}
