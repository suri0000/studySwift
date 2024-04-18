//
//  CoreDataManager.swift
//  WishList
//
//  Created by 예슬 on 4/18/24.
//

import Foundation
import CoreData

class CoreDataManager {
  static let shared = CoreDataManager()
  
  lazy var persistentContainer: NSPersistentContainer = {
      
      let container = NSPersistentContainer(name: "WishList")
      
      container.loadPersistentStores { _, error in
          if let error {
              fatalError("Failed to load persistent stores: \(error.localizedDescription)")
          }
      }
      return container
  }()
  
  //let context = CoreDataManager.shared.persistentContainer.viewContext
  
  private init() {}
  
  func saveWishProduct(product: Product) {
    let context = CoreDataManager.shared.persistentContainer.viewContext
    let wishProduct = Products(context: context)
    
    wishProduct.id = Int16(product.id)
    wishProduct.title = product.title
    wishProduct.thumbnail = product.thumbnail
    wishProduct.price = Int16(product.price)
    
    try? context.save()
    
//    do {
//      try context.save()
//      print("Product saved to CoreData")
//    } catch {
//      print("Error saving product to CoreData: \(error.localizedDescription)")
//    }
  }
  
  func fetchWishProduct() -> [Products] {
    let context = CoreDataManager.shared.persistentContainer.viewContext
    let request = Products.fetchRequest()
    
    do {
        let products = try context.fetch(request)
        return products
    } catch {
        print("Error fetching products: \(error.localizedDescription)")
        return []
    }

  }
}
