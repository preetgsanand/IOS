import Foundation
import UIKit

protocol CollectionDataProviderProtocol {
    associatedtype T
    
    func numberOfItems() -> Int
    func item(at : IndexPath) -> T?
    func add(items : [T])
    func removeAll()
}

class CollectionDataProvider<T> : CollectionDataProviderProtocol {
    
    var items : [T]
    
    init(items : [T]) {
        self.items = items
    }
    
    func numberOfItems() -> Int {
        return items.count
    }
    
    func item(at: IndexPath) -> T? {
        return items[at.row]
    }
    
    func add(items: [T]) {
        self.items.append(contentsOf: items)
    }
    
    func removeAll() {
        self.items.removeAll()
    }
    
}
