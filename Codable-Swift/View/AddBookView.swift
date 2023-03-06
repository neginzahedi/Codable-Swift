//
//  AddBookView.swift
//  Codable-Swift
//
//  Created by Negin Zahedi on 2023-02-28.
//
/** This file defines a view for adding a book to the library.
 - It includes several input fields for book information, such as title, author, page count, cover image, genre, summary, and published date.
 - It also includes a button for adding the book to the library.
 - It has another button for choosing a cover image from the photo library. The cover image can be selected using the ImagePicker view, which is presented as a sheet.
 - The view is implemented using a Form view, and it includes several sections for grouping the input fields.
 - The libraryManager object is used to add the book to the shared library.
 - The presentationMode object is used to dismiss the view when the book is added.
 */

import SwiftUI

struct AddBookView: View {
    @ObservedObject var libraryManager = LibraryManager.shared
    @Environment(\.presentationMode) var presentationMode
    
    @State private var title = ""
    @State private var author = ""
    @State private var pageCount = ""
    @State private var coverImageURL = ""
    @State private var genre = ""
    @State private var summary = ""
    @State private var publishedDate = ""
    @State private var selectedImage: UIImage?
    @State private var isShowingImagePicker = false
    
    var body: some View {
        Form{
            Section("Cover Image") {
                if selectedImage != nil {
                    Image(uiImage: selectedImage!)
                        .resizable()
                        .scaledToFit()
                        .frame(width:50)
                }
                Button("Choose Photo") {
                    isShowingImagePicker = true
                }
                .sheet(isPresented: $isShowingImagePicker) {
                    ImagePicker(sourceType: .photoLibrary, selectedImage: $selectedImage)
                }
            }
            Section("Book Information"){
                TextField("Title", text: $title)
                TextField("Author", text: $author)
                TextField("Published Date", text: $publishedDate)
                TextField("Page Count", text: $pageCount).keyboardType(.numberPad)
                TextField("Genre", text: $genre)
            }
            Section("Summary") {
                TextEditor(text: $summary)
                    .frame(height: 100)
            }
            Button {
                libraryManager.addBook(book: Book(title: self.title, author: self.author, pageCount: self.pageCount, coverImage: self.selectedImage!.pngData()!, genre: self.genre, summary: self.summary, publishedDate: self.publishedDate))
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Add to library")
            }.disabled(title.isEmpty || selectedImage == nil)
        }
        .navigationTitle("Add Book")
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
