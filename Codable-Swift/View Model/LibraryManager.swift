//
//  LibraryManager.swift
//  Codable-Swift
//
//  Created by Negin Zahedi on 2023-02-28.
//

/** This file contains a class called LibraryManager which is an ObservableObject.
 - It manages the user's library of books by adding, removing and saving books.
 - The @Published property wrapper is used to notify the view of any changes to the library.
 - The static let property libraryURL is a URL that points to the location where the user's library is saved.
 - The methods included in this class are addBook, removeBook, saveData and loadData, which are used to add a book to the library, remove a book from the library, save the library data to disk and load the library data from disk respectively.
 - The init() method calls the loadData() method upon initialization of the class to ensure the library data is loaded from disk.
 */

import SwiftUI

class LibraryManager: ObservableObject {
    @Published var library: [Book] = []
    static let shared = LibraryManager()
    static var libraryURL: URL {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        print(documentsDirectory)
        return documentsDirectory.appendingPathComponent("library.json")
    }
    
    init(){
        loadData()
    }
    
    func addBook(book: Book) {
        library.append(book)
        saveData()
    }
    
    func removeBook(bookID:UUID){
        library.removeAll(where: { book in
            book.id == bookID
        })
        saveData()
    }
    
    func saveData() {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        do {
            let data = try encoder.encode(library)
            try data.write(to: LibraryManager.libraryURL)
        } catch {
            print("Error saving library: \(error)")
        }
    }
    
    func loadData() {
        do {
            let data = try Data(contentsOf: LibraryManager.libraryURL)
            library = try JSONDecoder().decode([Book].self, from: data)
        } catch {
            print("Error loading library: \(error)")
        }
    }
}
