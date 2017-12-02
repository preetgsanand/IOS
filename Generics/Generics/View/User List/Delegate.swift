import Foundation

protocol LoaderDelegate {
    // LOADING
    
    func showLoading()
    func hideLoading()
}

protocol UserListDelegate {
    // PRESENTER -> VIEW
    
    func renderView(viewModels : [UserViewModel])
}

protocol UserListNavigationDelegate {
    // PRESENTER -> NAVIGATION
}
