//
//  Book.swift
//  QuanLyThuVien
//
//  Created by Dương Hoàng on 10/22/18.
//  Copyright © 2018 henry. All rights reserved.
//

import Foundation

class Book {
   var isbn = ""
   var subject = ""
   var author = ""
   var des = ""
   var publisher = ""
   var date = ""
   var pages = ""
   var coppies = ""
    
    init (bookDic : [String:String]) {
        isbn = bookDic["isbn"] ?? ""
        subject = bookDic["subject"] ?? ""
        author = bookDic["author"] ?? ""
        publisher = bookDic["publisher"] ?? ""
        date = bookDic["date"] ?? ""
        pages = bookDic["pages"] ?? ""
        coppies = bookDic["coppies"] ?? ""
        des = bookDic["des"] ?? ""
    }
    
    init(isbn: String, subject: String, author: String, des: String, publisher: String, date: String, coppies: String, pages: String) {
        self.isbn = isbn
        self.subject = subject
        self.author = author
        self.publisher = publisher
        self.date = date
        self.pages = pages
        self.coppies = coppies
        self.des = des
    }
    
    init () {
        
    }
}
