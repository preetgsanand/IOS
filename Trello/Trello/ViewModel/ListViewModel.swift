import Foundation

class ListListViewModel {
    private(set) var listList : [List]
    
    init(listList : [List]) {
        self.listList = listList
    }
    
    
}

class ListViewModel {
    private(set) var list : List
    
    init(list : List) {
        self.list = list
    }
}
