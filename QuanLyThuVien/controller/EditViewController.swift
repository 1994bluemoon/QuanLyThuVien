//
//  EditViewController.swift
//  QuanLyThuVien
//
//  Created by Dương Hoàng on 10/22/18.
//  Copyright © 2018 henry. All rights reserved.
//

import UIKit
import CoreData

class EditViewController: UIViewController {

    @IBOutlet weak var edtSubject: UITextField!
    @IBOutlet weak var edtAuthor: UITextField!
    @IBOutlet weak var edtDes: UITextField!
    @IBOutlet weak var btDelete: UIButton!
    @IBOutlet weak var edtPages: UITextField!
    
    @IBOutlet weak var edtCopies: UITextField!
    weak var bookLibraryDelegate: BookLibraryDelegate?
    weak var editDelegate: EditDelegate?
    
    var book: Book = Book()
    var bookLib = NSEntityDescription.insertNewObject(forEntityName: "BookLibrary", into: BLibrary.share.persistentContainer.viewContext) as! BookLibrary
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
                NotificationCenter.default.post(name: .addBook, object: bookLib)
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
        bookLib.subject = edtSubject.text ?? ""
        bookLib.author  = edtAuthor.text ?? ""
        bookLib.des     = edtDes.text ?? ""
        bookLib.pages   = Int16(edtPages.text ?? "0") ?? 0
        bookLib.coppies = edtCopies.text ?? ""
        bookLib.date = Date()
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

