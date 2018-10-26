//
//  BookLibrary.swift
//  QuanLyThuVien
//
//  Created by Dương Hoàng on 10/25/18.
//  Copyright © 2018 henry. All rights reserved.
//

import Foundation

class BookLibrary {
    static let share = BookLibrary()
    private var books: [String: Any] = [:]
    private var nsDict = NSDictionary()
    
    private init() {
        books = getPlistDictionary(resource: "PlistBook")
        nsDict = getNSDic(resource: "PlistBook")
    }
    
    func saveBook(book: Book) {
        
        
    }
    
    func getFilmData(byKey: String) -> [Book] {
        guard let array = books[byKey] as? [[String:String]] else { return [] }
        return convertDicToBook(books: array)
    }
    
    private func getPlistDictionary(resource: String) -> [String:Any] {
        if let path = Bundle.main.path(forResource: resource, ofType: "plist") {
            if let dic = NSDictionary(contentsOfFile: path) as? [String:Any] {
                return dic
            }
        }
        return [:]
    }
    
    private func getNSDic(resource: String) -> NSDictionary{
        if let path = Bundle.main.path(forResource: resource, ofType: "plist") {
            if let dic = NSDictionary(contentsOfFile: path) {
                return dic
            }
        }
        return NSDictionary()
    }
    
    private func convertDicToBook(books: [[String:String]]) -> [Book] {
        var listBooks: [Book] = []
        for item in books {
            let book = Book(bookDic: item)
            listBooks.append(book)
        }
        return listBooks
    }
}
