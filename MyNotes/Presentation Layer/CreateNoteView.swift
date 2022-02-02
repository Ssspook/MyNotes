import SwiftUI

struct CreateNoteView: View {
    @Environment(\.managedObjectContext) var moc
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
                        
                        let note = Note(context: moc)
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
        note.backgroundColorHex = getHexFromColor(color: noteBackgroundColor)
        note.textColorHex = getHexFromColor(color: noteTextColor)
        
        try? moc.save()
    }
    
    private func getHexFromColor(color: Color) -> String {
        let colorUiRepr = UIColor(color)
        
        let r = colorUiRepr.rgba.red
        let g = colorUiRepr.rgba.green
        let b = colorUiRepr.rgba.blue

        let rgb = (Int)(r * 255)<<16 | (Int)(g * 255)<<8 | (Int)(b * 255)<<0
        
        return String(format: "#%06X", rgb)
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
