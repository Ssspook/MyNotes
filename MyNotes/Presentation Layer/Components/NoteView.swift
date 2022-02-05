import SwiftUI

struct NoteView: View {
    @StateObject private var note: Note
    
    init(note: Note) {
        _note = StateObject(wrappedValue: note)
    }
    
    var body: some View {
        VStack {
            Text(note.noteText)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .lineLimit(Constants.lineLimit)
                .foregroundColor(note.textColor)
            
            Divider().background(.black)
            
            HStack {
                Text(note.dateString)
                    .foregroundColor(note.textColor)
                    .font(.system(size: Constants.dateFontSize))
                
                Spacer()
                
                NavigationLink {
                    NoteEditingView(note)
                } label: {
                    EmptyView()
                }
                .opacity(0.0)
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding()
        .background(note.backgroundColor)
        .cornerRadius(Constants.cornerRadius)
            
    }
}

struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        NoteView(note: Note(context: PersistenceController.shared.container.viewContext))
    }
}
