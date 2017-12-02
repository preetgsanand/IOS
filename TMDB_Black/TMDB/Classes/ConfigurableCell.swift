import Foundation

protocol ReusableCell {
    static var reusableIdentifier : String {get}
}

protocol ConfigurableCell : ReusableCell {
    associatedtype T
    
    func configure(_ item : T)
}
