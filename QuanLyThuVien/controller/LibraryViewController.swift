//
//  AdminViewController.swift
//  QuanLyThuVien
//
//  Created by Dương Hoàng on 10/22/18.
//  Copyright © 2018 henry. All rights reserved.
//

import UIKit
import CoreData

class LibraryViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var btAdd: UIBarButtonItem!
    @IBOutlet weak var tbTable: UITableView!
    
    var user: User = User()
    var books: [Book] = []
    var bookLibrary = [BookLibrary]()
    var searchList = [Book]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.modifyBook(_:)), name: .modifyBook, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.addBook(_:)), name: .addBook, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.deleteBook(_:)), name: .deleteBook, object: nil)
        
        btAdd.isEnabled = user.isAdmin
        books.append(Book(isbn: "ms111", subject: "book1", author: "famous", des: "sdfqwe", publisher: "asdfgfg",   date: "ahdfhafhkjas", coppies: "heh234y132", pages: "safghs"))
        reloadData()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .addBook, object: nil)
        NotificationCenter.default.removeObserver(self, name: .deleteBook, object: nil)
        NotificationCenter.default.removeObserver(self, name: .modifyBook, object: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pushlibrarytodetail" {
            let mh = segue.destination as! DetailViewController
            mh.book = sender as! Book
            mh.user = self.user
        }
    }
    
    @IBAction func btAddClicked(_ sender: Any) {
        performSegue(withIdentifier: "pushlibrarytoedit", sender: nil)
    }
    
    @objc func modifyBook(_ notification: Notification) {
        guard let book = notification.object as? Book else { return }
        let index = getItemIndex(book: book, inList: books)
        if index != -1 {
            books[index] = book
            reloadData()
        }
    }
    
    @objc func deleteBook(_ notification: Notification) {
        guard let book = notification.object as? Book else { return }
        let index = getItemIndex(book: book, inList: books)
        if index != -1 {
            books.remove(at: index)
            reloadData()
        }
    }
    
    @objc func addBook(_ notification: Notification) {
        guard let book = notification.object as? BookLibrary else { return }
        //if !isContains(book: book, inList: books) {
        //    books.append(book)
        //    reloadData()
        //}
        bookLibrary.append(book)
        BLibrary.share.saveContext()
        reloadData()
    }
    
    private func loadCoreData(){
        let fetchRequest = NSFetchRequest<BookLibrary>(entityName: "Library")
        do {
            bookLibrary = try BLibrary.share.persistentContainer.viewContext.fetch(fetchRequest).map{$0}
            reloadData()
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    private func reloadData() {
        searchList = convert(bookLibs: bookLibrary)
        tbTable.reloadData()
    }
    
    private func convert(bookLibs: [BookLibrary]) -> [Book]{
        var books = [Book]()
        for item in bookLibs {
            let book = Book()
            book.isbn = item.isbn ?? ""
            book.author = item.author ?? ""
            //book.date = item.date ?? ""
            //book.pages = item.pages ?? ""
            book.coppies = item.coppies ?? ""
            book.subject = item.subject ?? ""
            books.append(book)
        }
        return books
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
    
    private func search(text: String) {
        searchList = []
        for item in books {
            if item.subject.lowercased().contains(text){
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

extension LibraryViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text?.lowercased() {
            if text.isEmpty {
                reloadData()
            } else {
                search(text: text)
            }
        }
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        reloadData()
    }
}

extension Notification.Name {
    static let addBook = Notification.Name("addBook")
    static let deleteBook = Notification.Name("deleteBook")
    static let modifyBook = Notification.Name("modifyBook")
}
