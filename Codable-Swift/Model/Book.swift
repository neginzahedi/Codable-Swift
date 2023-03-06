//
//  Book.swift
//  Codable-Swift
//
//  Created by Negin Zahedi on 2023-02-28.
//
/*** This file defines a Swift struct Book that conforms to the Identifiable and Codable protocols.
 - The Identifiable protocol allows instances of Book to be uniquely identified, which is useful for SwiftUI views.
 - The Codable protocol allows instances of Book to be encoded into and decoded from a data representation, such as JSON.
 - Book has several properties of a specific type and represents a different aspect of a book, such as the title, author, and cover image data.
 */

import Foundation

struct Book: Identifiable,Codable {
    var id = UUID()
    
    let title: String
    let author: String
    let pageCount: String
    let coverImage: Data
    let genre: String
    let summary: String
    let publishedDate: String
}
