//
//  BookTableViewCell.swift
//  QuanLyThuVien
//
//  Created by Dương Hoàng on 10/26/18.
//  Copyright © 2018 henry. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    @IBOutlet weak var tvTitile: UILabel!
   
    func setData(title: String) {
        tvTitile.text = title
    }

}
