//
//  CollectionDataSource.swift
//  Generics
//
//  Created by Preet G S Anand on 11/15/17.
//  Copyright © 2017 Preet G S Anand. All rights reserved.
//

import Foundation
import UIKit

//class CollectionDataSource<Provider : CollectionDataProvider, Cell : UICollectionViewCell>: NSObject,
//    UICollectionViewDataSource
//    where Cell : ConfigurableCell,
//Provider.T == Cell.T {
//
//
//
//    let provider : Provider
//
//    init(provider : Provider) {
//        self.provider = provider
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return provider.numberOfItems()
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.reuseIndentifier, for: indexPath) as? Cell else {
//            return UICollectionViewCell()
//        }
//        let item = provider.itemAt(at: indexPath)
//        if let item = item {
//            cell.configure(item)
//        }
//        return cell
//    }
//}

class CollectionDataSource<T, Cell : UICollectionViewCell>: NSObject,
    UICollectionViewDataSource
    where Cell : ConfigurableCell,
    Cell.T == T{
    
    
    
    let provider : ArrayDataProvider<T>
    
    init(items : [T]) {
        let provider = ArrayDataProvider(items : items)
        self.provider = provider
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return provider.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.reuseIndentifier, for: indexPath) as? Cell else {
            return UICollectionViewCell()
        }
        let item = provider.itemAt(at: indexPath)
        if let item = item {
            cell.configure(item)
        }
        return cell
    }
}

//class CollectionArrayDataSource<T, Cell : UICollectionViewCell> : CollectionDataSource<ArrayDataProvider<T>, Cell>
//    where Cell : ConfigurableCell, Cell.T == T{
//
//    init(items : [T]) {
//        let provider = ArrayDataProvider(items : items)
//        super.init(provider: provider)
//    }
//
//    func itemAt(at indexPath : IndexPath) -> T? {
//        return provider.itemAt(at: indexPath)
//    }
//
//}



