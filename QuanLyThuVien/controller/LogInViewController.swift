//
//  LogInViewController.swift
//  QuanLyThuVien
//
//  Created by Dương Hoàng on 10/22/18.
//  Copyright © 2018 henry. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {

    @IBOutlet weak var edtUserName: UITextField!
    @IBOutlet weak var edtPass: UITextField!
    
    var users = [User]()

    override func viewDidLoad() {
        super.viewDidLoad()
        users.append(User(userName: "a", passWord: "1", isAdmin: true))
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pushlogintolibrary" {
            let mh = segue.destination as! LibraryViewController
            mh.user = sender as! User
        }
    }
    
    @IBAction func btLoginClicked(_ sender: Any) {
        if checkUser() {
            let user = getLogInUser()
            performSegue(withIdentifier: "pushlogintolibrary", sender: user)
        } else {
            //notify
        }
    }
    
    private func checkUser() -> Bool {
        let username: String = edtUserName.text ?? ""
        let pass: String = edtPass.text ?? ""
        if  username.isEmpty || pass.isEmpty {
            return false
        }
        return users.contains(where: {$0.userName == username && $0.passWord == pass})
    }
    
    private func getLogInUser() -> User {
        let username: String = edtUserName.text ?? ""
        let pass: String = edtPass.text ?? ""
        for user in users {
            if user.userName == username && user.passWord == pass {
                return user
            }
        }
        return User()
    }
}

