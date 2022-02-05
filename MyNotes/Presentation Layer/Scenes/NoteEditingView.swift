import SwiftUI

struct NoteEditingView: View {
    @StateObject private var note: Note
    
    init(_ note: Note) {
        _note = StateObject(wrappedValue: note)
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                TextEditor(text: $note.noteText)
                    .onChange(of: note.noteText) { newText in
                         note.noteText = newText
                    }
                    .padding()
                    .frame(width: getNoteWidth(geo: geometry))
                    .cornerRadius(Constants.cornerRadius)
                    .overlay(RoundedRectangle(cornerRadius: Constants.cornerRadius).strokeBorder(.indigo))
                    .mask(RoundedRectangle(cornerRadius: Constants.cornerRadius))
                
                ColorPickerView(color: $note.backgroundColor, text: "Pick a note background color", width: getNoteWidth(geo: geometry))
                
                ColorPickerView(color: $note.textColor, text: "Pich a note text color", width: getNoteWidth(geo: geometry))
            }
            .onDisappear {
                if note.noteText.isEmpty {
                    note.noteText = "Empty note"
                }
                PersistenceController.shared.save()
            }
            .frame(
                width: geometry.size.width,
                height: geometry.size.height,
                alignment: .center
            )
        }
    }
    
    private func getNoteWidth(geo: GeometryProxy) -> CGFloat {
        geo.size.width * Constants.noteCreationFieldScale
    }
}

struct NoteEditingView_Previews: PreviewProvider {
    static var previews: some View {
        NoteEditingView(Note(context: PersistenceController.shared.container.viewContext))
                                 
    }
}
