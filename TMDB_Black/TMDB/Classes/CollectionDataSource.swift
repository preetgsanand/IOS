
import Foundation
import UIKit

class CollectionDataSource<T, Cell : UICollectionViewCell> : NSObject, UICollectionViewDataSource
    where Cell : ConfigurableCell,
    Cell.T == T{
  
    
    let provider : CollectionDataProvider<T>
    let view : ScrollProtocol?
    
    init(items : [T], view : ScrollProtocol?) {
        self.provider = CollectionDataProvider(items : items)
        self.view = view
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return provider.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.reusableIdentifier, for: indexPath) as? Cell else {
            return UICollectionViewCell()
        }
        if indexPath.item == provider.numberOfItems()-1 && provider.items.count > 4 {
            view?.didReachEnd()
        }
        if let item = provider.item(at: indexPath) {
            cell.configure(item)
        }
        return cell
    }
    
    func add(items : [T]) {
        provider.add(items: items)
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
