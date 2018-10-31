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
    
    var book = Book()
    var user = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateData(_:)), name: .modifyBook, object: nil)
        
        doFirst()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .modifyBook, object: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pushdetailtoedit" {
            let mh = segue.destination as! EditViewController
            mh.book = sender as! Book
        }
    }
    
    @IBAction func btEditClicked(_ sender: Any) {
        performSegue(withIdentifier: "pushdetailtoedit", sender: book)
    }
    
    @objc private func updateData(_ notification: Notification) {
        guard let book = notification.object as? Book else { return }
        self.book = book
        tbTable.reloadData()
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
