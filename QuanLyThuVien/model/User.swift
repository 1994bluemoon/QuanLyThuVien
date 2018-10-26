//
//  User.swift
//  QuanLyThuVien
//
//  Created by Dương Hoàng on 10/22/18.
//  Copyright © 2018 henry. All rights reserved.
//

import Foundation

class  User {
    var userId: String = ""
    var userName = ""
    var passWord = ""
    var isAdmin = false
    
    init(userName: String, passWord: String, isAdmin: Bool) {
        self.userName = userName
        self.passWord = passWord
        self.isAdmin = isAdmin
    }
    
    init () {
        
    }
}
