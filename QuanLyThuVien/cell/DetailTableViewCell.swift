//
//  DetailTableViewCell.swift
//  QuanLyThuVien
//
//  Created by Dương Hoàng on 10/26/18.
//  Copyright © 2018 henry. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    @IBOutlet weak var tvSubject: UILabel!
    @IBOutlet weak var tvContent: UITextView!
    
    var book = Book()
    var index = 0
    
    func setData(book: Book, index: Int) {
        self.book = book
        self.index = index
        bindView()
    }
    private func bindView() {
        switch index {
        case 0:
            tvSubject.text = "Subject"
            tvContent.text = book.subject
        case 1:
            tvSubject.text = "Author"
            tvContent.text = book.author
        case 2:
            tvSubject.text = "Description"
            tvContent.text = book.des
        case 3:
            tvSubject.text = "Publisher"
            tvContent.text = book.publisher
        case 4:
            tvSubject.text = "Date"
            tvContent.text = book.date
        case 5:
            tvSubject.text = "Pages"
            tvContent.text = book.pages
        case 6:
            tvSubject.text = "Coppies"
            tvContent.text = book.coppies
        default:
            break
        }
    }
}
