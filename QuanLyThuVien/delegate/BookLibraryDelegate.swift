//
//  BookLibraryDelegate.swift
//  QuanLyThuVien
//
//  Created by Dương Hoàng on 10/26/18.
//  Copyright © 2018 henry. All rights reserved.
//

import Foundation

protocol BookLibraryDelegate : class{
    func addBook(book: Book)
    func updateLib(book: Book, fDelete: Bool)
}
