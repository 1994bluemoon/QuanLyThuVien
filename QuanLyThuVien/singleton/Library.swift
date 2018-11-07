//
//  BookLibrary.swift
//  QuanLyThuVien
//
//  Created by Dương Hoàng on 10/25/18.
//  Copyright © 2018 henry. All rights reserved.
//

import Foundation
import CoreData

class BLibrary {
    static let share = BLibrary()
    private var books: [String: Any] = [:]
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Library")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    private init() {
        
    }
    
    func saveBook(book: Book) {
        
        
    }
    
    func getBookData(byKey: String) -> [Book] {
        guard let array = books[byKey] as? [[String:String]] else { return [] }
        return convertDicToBook(books: array)
    }
    
    private func getPlistDictionary(resource: String) -> [String:Any] {
        if let path = Bundle.main.path(forResource: resource, ofType: "plist") {
            if let dic = NSDictionary(contentsOfFile: path) as? [String:Any] {
                return dic
            }
        }
        return [:]
    }
    
    private func getNSDic(resource: String) -> NSDictionary{
        if let path = Bundle.main.path(forResource: resource, ofType: "plist") {
            if let dic = NSDictionary(contentsOfFile: path) {
                return dic
            }
        }
        return NSDictionary()
    }
    
    private func convertDicToBook(books: [[String:String]]) -> [Book] {
        var listBooks: [Book] = []
        for item in books {
            let book = Book(bookDic: item)
            listBooks.append(book)
        }
        return listBooks
    }
}
