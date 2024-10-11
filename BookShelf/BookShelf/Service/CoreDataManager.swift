//
//  CoreDataManager.swift
//  BookShelf
//
//  Created by 예슬 on 5/9/24.
//

import CoreData
import Foundation

class CoreDataManager {
  
  static let shared = CoreDataManager()
  private init() {}
  
  lazy var persistentContainer: NSPersistentContainer = {
    
    let container = NSPersistentContainer(name: "AddedBook")
    
    container.loadPersistentStores { _, error in
      if let error {
        fatalError("Failed to load persistent stores: \(error.localizedDescription)")
      }
    }
    return container
  }()
  
  // Create
  func saveBook(_ selectedBook: Document) {
    let context = CoreDataManager.shared.persistentContainer.viewContext
    let addedBook = AddedBook(context: context)
    
    addedBook.title = selectedBook.title
    addedBook.author = selectedBook.authors.joined(separator: ",")
    addedBook.thumbnail = selectedBook.thumbnail
    
    try? context.save()
  }
  
  // Read
  func fetchBook() -> [AddedBook] {
    let context = CoreDataManager.shared.persistentContainer.viewContext
    let request = AddedBook.fetchRequest()
    
    do {
      let addedBook = try context.fetch(request)
      return addedBook
    } catch {
      print("Error fetching products: \(error.localizedDescription)")
      return []
    }
  }
  
  // Delete all
  func deleteAllBook() {
    let context = CoreDataManager.shared.persistentContainer.viewContext
    let deleteRequest = NSBatchDeleteRequest(fetchRequest: AddedBook.fetchRequest())
    
    do {
      try context.execute(deleteRequest)
      try? context.save()
    } catch {
      print("데이터 삭제 중 오류 발생: \(error.localizedDescription)")
    }
  }
  
  // Delete One
  func deleteOneBook(_ selectedBook: AddedBook) {
    let context = CoreDataManager.shared.persistentContainer.viewContext
    let request = AddedBook.fetchRequest()
    
    guard let book = try? context.fetch(request) else { return }
    guard let deleteBook = book.filter({ AddedBook in
      AddedBook.title == selectedBook.title
    }).first else { return }
    
    context.delete(deleteBook)
    try? context.save()
  }
}
