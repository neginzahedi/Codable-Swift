//
//  BookView.swift
//  Codable-Swift
//
//  Created by Negin Zahedi on 2023-02-28.
//
/*** This file defines the BookView struct that displays the details of a book passed as input.
 - It uses SwiftUI to create the view and has an @ObservedObject property that is used to removed the book from library array, when the "Remove from Library" button is tapped.
 - The view displays the cover image, title, author, page count, genre, release date, and summary of the book. It also includes a button to remove the book from the library.
 - The view is dismissed when the button is tapped using the presentationMode environment variable.
 */

import SwiftUI

struct BookView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var libraryManager = LibraryManager.shared
    let book: Book
    
    var body: some View {
        VStack{
            if let image = UIImage(data: book.coverImage) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150)
            }
            VStack{
                Text(book.title)
                    .font(.title3)
                    .fontWeight(.bold)
                Text(book.author)
                    .font(.body)
                    .foregroundColor(Color.gray)
            }.padding()
            HStack(alignment: .center,spacing: 20){
                VStack(){
                    Text(book.pageCount)
                        .fontWeight(.bold)
                        .font(.footnote)
                        .padding(.bottom,1)
                    Text("Pages")
                        .foregroundColor(Color.gray)
                        .font(.footnote)
                }
                Divider().frame(height: 40)
                VStack{
                    Text(book.genre)
                        .font(.footnote)
                        .fontWeight(.bold)
                        .padding(.bottom,1)
                    Text("Genre")
                        .foregroundColor(Color.gray)
                        .font(.footnote)
                }
                Divider().frame(height: 40)
                VStack{
                    Text(book.publishedDate)
                        .fontWeight(.bold)
                        .font(.footnote)
                        .padding(.bottom,1)
                    Text("Release")
                        .foregroundColor(Color.gray)
                        .font(.footnote)
                }
            }.padding()
            Divider()
            ScrollView{
                VStack(alignment: .leading, spacing: 10){
                    Text("Summary")
                        .font(.title3)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                    Text(book.summary)
                        .font(.body)
                        .multilineTextAlignment(.leading)
                }.padding()
            }
            Button {
                libraryManager.removeBook(bookID: book.id)
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Remove from Library")
                    .foregroundColor(.red)
                    .font(.caption)
                    .bold()
            }
        }.padding()
    }
}
