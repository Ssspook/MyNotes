import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "MyNotes")
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core data failed with: \(error.localizedDescription)")
            }
        }
    }
}
