//
//  EditViewController.swift
//  QuanLyThuVien
//
//  Created by Dương Hoàng on 10/22/18.
//  Copyright © 2018 henry. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {

    @IBOutlet weak var edtSubject: UITextField!
    @IBOutlet weak var edtAuthor: UITextField!
    @IBOutlet weak var edtDes: UITextField!
    @IBOutlet weak var btDelete: UIButton!
    @IBOutlet weak var edtPages: UITextField!
    
    @IBOutlet weak var edtCopies: UITextField!
    weak var bookLibraryDelegate: BookLibraryDelegate?
    weak var editDelegate: EditDelegate?
    
    var book = Book()
    var isEdit = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doFirst()
    }
    @IBAction func btDoneClicked(_ sender: Any) {
        createBook()
        if  checkAll() {
            if isEdit {
                NotificationCenter.default.post(name: .modifyBook, object: book)
                editDelegate?.sendBackEdited(book: book)
            } else {
                NotificationCenter.default.post(name: .addBook, object: book)
            }
            self.navigationController?.popViewController(animated: true)
        }
    }
    @IBAction func btDeleteClicked(_ sender: Any) {
        NotificationCenter.default.post(name: .deleteBook, object: book)
        let index = getLibVCPos()
        if index != -1 {
            let vc = self.navigationController?.viewControllers[index] as! LibraryViewController
            self.navigationController?.popToViewController(vc, animated: true)
        }
    }
    
    private func getLibVCPos() -> Int {
        guard let vcs  = self.navigationController?.viewControllers else { return -1 }
        for (index, vc) in vcs.enumerated() {
            if let _ = vc as? LibraryViewController {
                return index
            }
        }
        return -1
    }
    
    private func createBook() {
        book.subject = edtSubject.text ?? ""
        book.author  = edtAuthor.text ?? ""
        book.des     = edtDes.text ?? ""
        book.pages   = edtPages.text ?? ""
        book.coppies = edtCopies.text ?? ""
        book.date = ""
        if !isEdit {
            book.isbn = String(Date().timeIntervalSince1970)
        }
    }
    
    private func checkAll() -> Bool {
        if  book.subject.isEmpty || book.author.isEmpty || book.des.isEmpty || book.pages.isEmpty || book.coppies.isEmpty || book.isbn.isEmpty {
            return false
        } else {
            return true
        }
    }
    
    private func doFirst() {
        if book.isbn.isEmpty{
            btDelete.isHidden = true
            isEdit = false
        } else {
            btDelete.isHidden = false
            isEdit = true
        }
        edtSubject.text = book.subject
        edtAuthor.text  =  book.author
        edtDes.text     = book.des
        edtPages.text   = book.pages
        edtCopies.text  = book.coppies
    }
}

