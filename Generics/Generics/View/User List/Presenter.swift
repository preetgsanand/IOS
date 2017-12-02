import Foundation

class UserPresenter {
    
    let view : UserListDelegate
    let loader : LoaderDelegate
    
    init(view : UserListDelegate, loader : LoaderDelegate) {
        self.view = view
        self.loader = loader
    }
    
    func viewDidLoad() {
        fetchUserList()
    }
    
    func fetchUserList() {
        loader.showLoading()
        DataService.instance.fetchUserList { (success, users) in
            var viewModels = [UserViewModel]()
            for i in 0..<users.count {
                let viewModel = UserViewModel(name : users[i].name,
                                              designation : users[i].designation)
                viewModels.append(viewModel)
            }
            self.view.renderView(viewModels: viewModels)
            self.loader.hideLoading()
        }
    }
}
