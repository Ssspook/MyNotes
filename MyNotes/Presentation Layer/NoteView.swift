import SwiftUI

struct NoteView: View {
    @StateObject private var noteViewModel: NoteViewModel
    private let coreDataService: CoreDataService
    
    init(note: Note, _ coreDataServ: CoreDataService) {
        _noteViewModel = StateObject(wrappedValue: initNoteViewModel(note: note))
        coreDataService = coreDataServ
    }
    
    var body: some View {
        VStack {
            Text(noteViewModel.text)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .lineLimit(Constants.lineLimit)
                .foregroundColor(noteViewModel.foregroundColor)
            
            Divider().background(.black)
            
            HStack {
                Text(noteViewModel.date)
                    .foregroundColor(noteViewModel.foregroundColor)
                    .font(.system(size: Constants.dateFontSize))
                
                Spacer()
                
                NavigationLink {
                    NoteEditingView(note: noteViewModel)
                } label: {
                    EmptyView()
                }
                .opacity(0.0)
                .buttonStyle(PlainButtonStyle())
            
            }
        }
        .padding()
        .background(noteViewModel.noteBackgroundColor)
        .cornerRadius(Constants.cornerRadius)
            
    }
    
    private func initNoteViewModel(note: Note) -> NoteViewModel {
        let noteViewModel = NoteViewModel(noteText: note.noteText ?? "Empty note", date: note.date ?? Date())
        noteViewModel.foregroundColor = Color(hex: note.textColorHex ?? Constants.whiteHex)
        noteViewModel.noteBackgroundColor = Color(hex: note.backgroundColorHex ?? Constants.blackHex)
        
        return noteViewModel
    }
}

struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        NoteView(noteVM: NoteViewModel(noteText: "sd", date: Date()))
    }
}
