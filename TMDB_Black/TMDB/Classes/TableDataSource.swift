
import Foundation
import UIKit

class TableDataSource<T, Cell : UITableViewCell> : NSObject, UITableViewDataSource
where Cell : ConfigurableCell,
Cell.T == T{
    
    var provider : CollectionDataProvider<T>

    init(items : [T]) {
        self.provider = CollectionDataProvider(items : items)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return provider.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cell.reusableIdentifier) as? Cell else {
            return UITableViewCell()
        }
        
        if let item = provider.item(at: indexPath) {
            cell.configure(item)
        }
        return cell
    }
    
    
    func add(item : [T]) {
        self.provider.add(items: item)
    }
    
    func itemAt(at indexPath : IndexPath) -> T? {
        return provider.item(at: indexPath)
    }
    
    func removeAll() {
        provider.removeAll()
    }
    
    func numberOfItems() -> Int {
        return provider.numberOfItems()
    }
    
    
    
}
