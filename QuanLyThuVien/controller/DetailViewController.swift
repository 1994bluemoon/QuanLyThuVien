//
//  DetailViewController.swift
//  QuanLyThuVien
//
//  Created by Dương Hoàng on 10/22/18.
//  Copyright © 2018 henry. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var tbTable: UITableView!
    @IBOutlet weak var btEdit: UIBarButtonItem!
    
    weak var bookLibraryDelegate: BookLibraryDelegate?
    var book = Book()
    var user = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doFirst()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pushdetailtoedit" {
            let mh = segue.destination as! EditViewController
            mh.bookLibraryDelegate = bookLibraryDelegate
            mh.editDelegate = self
            mh.book = sender as! Book
        }
    }
    
    @IBAction func btEditClicked(_ sender: Any) {
        performSegue(withIdentifier: "pushdetailtoedit", sender: book)
    }
    
    func doFirst() {
        btEdit.isEnabled = user.isAdmin
    }
}

extension DetailViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailTableViewCell") as? DetailTableViewCell else {
            return UITableViewCell()
        }
        cell.setData(book: book, index: indexPath.row)
        return cell
    }
}

extension DetailViewController : EditDelegate {
    func sendBackEdited(book: Book)  {
        self.book = book
        if book.isbn.isEmpty {
            self.navigationController?.popViewController(animated: true)
        } else {
            tbTable.reloadData()
        }
    }
}
