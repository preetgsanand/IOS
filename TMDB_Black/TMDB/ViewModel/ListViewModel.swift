import Foundation

class ListViewModel {
    var title : String
    var items : [Any]
    var identifier : String
    
    init(title : String, items : [Any], identifier : String) {
        self.title = title
        self.items = items
        self.identifier = identifier
        
        // Genre, Movie, Tv
    }
}
