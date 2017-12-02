import Foundation
import UIKit

protocol CollectionDataProvider {
    associatedtype T
    
    func numberOfItems() -> Int
    func itemAt(at indexPath : IndexPath) -> T?
}

public class ArrayDataProvider<T> : CollectionDataProvider {
    var items : [T]
    
    init(items : [T]) {
        self.items = items
    }
    
    func numberOfItems() -> Int {
        return items.count
    }
    
    func itemAt(at indexPath: IndexPath) -> T? {
        return items[indexPath.row]
    }
    
}
