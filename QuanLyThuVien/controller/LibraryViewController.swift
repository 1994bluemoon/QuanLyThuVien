//
//  AdminViewController.swift
//  QuanLyThuVien
//
//  Created by Dương Hoàng on 10/22/18.
//  Copyright © 2018 henry. All rights reserved.
//

import UIKit

class LibraryViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var btAdd: UIBarButtonItem!
    @IBOutlet weak var tbTable: UITableView!
    
    var user: User = User()
    var books = [Book]()
    var searchList = [Book]()

    override func viewDidLoad() {
        super.viewDidLoad()
        btAdd.isEnabled = user.isAdmin
        books.append(Book(isbn: "ms111", subject: "book1", author: "famous", des: "sdfqwe", publisher: "asdfgfg",   date: "ahdfhafhkjas", coppies: "heh234y132", pages: "safghs"))
        reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pushlibrarytoedit" {
            let mh = segue.destination as! EditViewController
            mh.bookLibraryDelegate = self
        }
        if segue.identifier == "pushlibrarytodetail" {
            let mh = segue.destination as! DetailViewController
            mh.bookLibraryDelegate = self
            mh.book = sender as! Book
            mh.user = self.user
        }
    }
    
    @IBAction func btAddClicked(_ sender: Any) {
        performSegue(withIdentifier: "pushlibrarytoedit", sender: nil)
    }
    
    private func reloadData() {
        searchList = books
        tbTable.reloadData()
    }
    
    private func getItemIndex(book: Book, inList: [Book]) -> Int{
        for (index, item) in inList.enumerated() {
            if item.isbn == book.isbn {
                return index
            }
        }
        return -1
    }
    
    private func isContains(book: Book, inList: [Book]) -> Bool {
        return inList.contains(where: {$0.isbn == book.isbn})
    }
    
    func search(text: String) {
        searchList = []
        for item in books {
            if item.subject.contains(text){
                searchList.append(item)
            }
        }
        tbTable.reloadData()
    }
}

extension LibraryViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookTableViewCell") as? BookTableViewCell else {
            return UITableViewCell()
        }
        cell.setData(title: searchList[indexPath.row].subject)
        return cell
    }
}

extension LibraryViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "pushlibrarytodetail", sender: books[indexPath.row])
    }
}

extension LibraryViewController : BookLibraryDelegate {
    func updateLib(book: Book, fDelete: Bool) {
        let index = getItemIndex(book: book, inList: books)
        if index != -1 {
            if fDelete {
                books.remove(at: index)
            } else {
                books[index] = book
            }
            reloadData()
        }
    }
    
    func addBook(book: Book) {
        if !isContains(book: book, inList: books) {
            books.append(book)
            reloadData()
        }
    }
}
extension LibraryViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            if text.isEmpty {
                reloadData()
            } else {
                search(text: text)
            }
        }
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if  searchText.isEmpty {
            searchBar.resignFirstResponder()
            reloadData()
        }
    }
}
