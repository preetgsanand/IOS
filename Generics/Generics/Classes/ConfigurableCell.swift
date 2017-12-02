import Foundation

protocol ResuableCell {
    static var reuseIndentifier : String {
        get    }
}

extension ResuableCell {
    static var resuseIndetifier : String {
        return String(describing : self)
    }
}

protocol ConfigurableCell : ResuableCell {
    associatedtype T
    
    func configure(_ item : T)
}
