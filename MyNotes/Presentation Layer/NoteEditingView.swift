import SwiftUI

struct NoteEditingView: View {
    @State private var coreDataNote: Note
    @EnvironmentObject var note: Note
    
    init(note: Note) {
        coreDataNote = note
    }
    
    var body: some View {
        
        GeometryReader { geometry in
            VStack {
                TextEditor(text: $coreDataNote.noteText)
                    .onChange(of: coreDataNote.noteText) { newText in
                         coreDataNote.noteText = newText
                    }
                    .padding()
                    .frame(width: getNoteWidth(geo: geometry))
                    .cornerRadius(Constants.cornerRadius)
                    .overlay(RoundedRectangle(cornerRadius: Constants.cornerRadius).strokeBorder(.indigo))
                    .mask(RoundedRectangle(cornerRadius: Constants.cornerRadius))
                
                ColorPickerView(color: $coreDataNote.backgroundColor, text: "Pick a note background color", width: getNoteWidth(geo: geometry))
                
                ColorPickerView(color: $coreDataNote.textColor, text: "Pich a note text color", width: getNoteWidth(geo: geometry))
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
        NoteEditingView(note: Note(context: PersistenceController.preview.container.viewContext))
                                 
    }
}
