import SwiftUI

struct CreateNoteView: View {
    @State private var noteText = ""
    @State private var noteBackgroundColor = Color.indigo
    @State private var noteTextColor = Color.white
    
    var body: some View {
        
        GeometryReader { geometry in
            VStack {
                TextEditor(text: $noteText)
                    .padding()
                    .frame(width: getNoteWidth(geo: geometry))
                    .cornerRadius(Constants.cornerRadius)
                    .overlay(RoundedRectangle(cornerRadius: Constants.cornerRadius).strokeBorder(.indigo))
                    .mask(RoundedRectangle(cornerRadius: Constants.cornerRadius))
                    .onDisappear {
                        let currentDate = Date()
                        
                        let note = Note(context: PersistenceController.shared.container.viewContext)
                        
                        saveToDataBase(note: note, currentDate: currentDate)
                    }
                
                ColorPickerView(color: $noteBackgroundColor, text: "Pick a note background color", width: getNoteWidth(geo: geometry))
                
                ColorPickerView(color: $noteTextColor, text: "Pich a note text color", width: getNoteWidth(geo: geometry))
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
    
    private func saveToDataBase(note: Note, currentDate: Date) {
        note.noteText = placeholderIfNoteTextIsEmpty(noteText)
        note.date = currentDate
        note.backgroundColorHex = UIColor(noteBackgroundColor).toHexString()
        note.textColorHex = UIColor(noteTextColor).toHexString()
        
        PersistenceController.shared.save()
    }
    
    private func placeholderIfNoteTextIsEmpty(_ text: String) -> String {
        text.isEmpty ? "Empty note" : text
    }
}

struct CreateNoteView_Previews: PreviewProvider {
    static var previews: some View {
        CreateNoteView()
            .previewInterfaceOrientation(.portrait)
        
        CreateNoteView()
            .previewDevice("iPhone 12 Pro Max")

    }
}
