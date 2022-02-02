import SwiftUI

struct NoteEditingView: View {
    @StateObject private var noteViewModel: NoteViewModel
    private let coreDataService: CoreDataService
    
    init(note: Note, _ coreDataServ: CoreDataService) {
        _noteViewModel = StateObject(wrappedValue: initNoteViewModel(note: note))
        coreDataService = coreDataServ
    }
    
    var body: some View {
        
        GeometryReader { geometry in
            VStack {
                TextEditor(text: $noteViewModel.text)
                    .onChange(of: noteViewModel.text) { newText in
                        noteViewModel.editNote(newText: newText)
                        
                        coreDataService.saveData()
                    }
                    .padding()
                    .frame(width: getNoteWidth(geo: geometry))
                    .cornerRadius(Constants.cornerRadius)
                    .overlay(RoundedRectangle(cornerRadius: Constants.cornerRadius).strokeBorder(.indigo))
                    .mask(RoundedRectangle(cornerRadius: Constants.cornerRadius))
                    .onDisappear {
                        let newNoteData = NoteProperties(text: noteViewModel.text,
                                                         textColorHex: noteViewModel.foregroundColor.to,
                                                         backgroundColorHex: noteViewModel.noteBackgroundColor,
                                                         dateOfCreation: noteViewModel.date)
                        
                    }
                
                ColorPickerView(color: $noteViewModel.noteBackgroundColor, text: "Pick a note background color", width: getNoteWidth(geo: geometry))
                
                ColorPickerView(color: $noteViewModel.foregroundColor, text: "Pich a note text color", width: getNoteWidth(geo: geometry))
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
    
    private func initNoteViewModel(note: Note) -> NoteViewModel {
        let noteViewModel = NoteViewModel(noteText: note.noteText ?? "Empty note", date: note.date ?? Date())
        noteViewModel.foregroundColor = Color(hex: note.textColorHex ?? Constants.whiteHex)
        noteViewModel.noteBackgroundColor = Color(hex: note.backgroundColorHex ?? Constants.blackHex)
        
        return noteViewModel
    }
}

struct NoteEditingView_Previews: PreviewProvider {
    static var previews: some View {
        NoteEditingView(noteVM: NoteViewModel(noteText: "dscef", date: Date()))
    }
}
