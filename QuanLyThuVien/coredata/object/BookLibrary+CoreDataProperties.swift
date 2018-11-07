//
//  BookLibrary+CoreDataProperties.swift
//  QuanLyThuVien
//
//  Created by Dương Hoàng on 11/7/18.
//  Copyright © 2018 henry. All rights reserved.
//
//

import Foundation
import CoreData


extension BookLibrary {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BookLibrary> {
        return NSFetchRequest<BookLibrary>(entityName: "BookLibrary")
    }

    @NSManaged public var isbn: String?
    @NSManaged public var subject: String?
    @NSManaged public var author: String?
    @NSManaged public var des: String?
    @NSManaged public var publisher: String?
    @NSManaged public var date: NSDate?
    @NSManaged public var pages: Int16
    @NSManaged public var coppies: String?

}
