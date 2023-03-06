//
//  LibraryView.swift
//  Codable-Swift
//
//  Created by Negin Zahedi on 2023-02-28.
//
/*** This file contains the LibraryView, which is the main view of the application where the user's library of books is displayed.
 - It uses an @ObservedObject to listen to changes in the shared instance of the LibraryManager, which manages the user's library.
 - If the library is empty, an EmptyLibraryView is displayed, otherwise a List of Book_RowViews is shown, with each row representing a book in the library.
 - Each row is a NavigationLink to the BookView, which displays the details of the book.
 - The view also includes a toolbar item to add a new book to the library.
 - The Book_RowView is a subview used to display each book in the library list, which contains the book's cover image, title, and author.
 */

import SwiftUI

struct LibraryView: View {
    @ObservedObject var libraryManager = LibraryManager.shared
    
    var body: some View {
        NavigationStack{
            VStack{
                if libraryManager.library.isEmpty{
                    EmptyLibraryView()
                }
                else{
                    List(libraryManager.library){ book in
                        NavigationLink(destination: BookView(book: book)) {
                            Book_RowView(book: book)
                        }
                    }
                }
            }
            .navigationTitle("Library")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        AddBookView()
                    } label: {
                        Text("Add Book")
                    }
                }
            }
        }
    }
    
    func EmptyLibraryView() -> some View{
        VStack(alignment: .center){
            Spacer()
            Image("home-books")
                .resizable()
                .scaledToFit()
                .frame(width: 300)
                .padding()
            Text("Add book to your library and it will be shown here!").foregroundColor(.secondary).font(.caption)
            Spacer()
        }.padding()
    }
}

struct Book_RowView: View{
    let book: Book
    
    var body: some View{
        HStack(spacing: 20){
            Image(uiImage: UIImage(data: book.coverImage)!)                                    .resizable()
                .scaledToFit()
                .frame(width: 100)
                .shadow(color: .gray, radius: 5.0)
            VStack (alignment: .leading ,spacing: 15){
                Text(book.title)
                    .font(.headline)
                Text(book.author)
                    .font(.headline)
                    .foregroundColor(.gray)
            }
        }
    }
}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView()
    }
}
