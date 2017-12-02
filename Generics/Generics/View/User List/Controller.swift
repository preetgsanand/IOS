import UIKit

class UserListController: UIViewController {

    
    @IBOutlet weak var userCollection : UICollectionView!
    
    var presenter : UserPresenter?
    var loader : UIActivityIndicatorView!
    var dataSource : UserDataSource?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        userCollection.delegate = self
        presenter?.viewDidLoad()

    }
    
    func initialize() {
        loader = UIActivityIndicatorView()
        loader.activityIndicatorViewStyle = .gray
        loader.hidesWhenStopped = true
        presenter = UserPresenter(view: self, loader: self)
    }
}

extension UserListController : LoaderDelegate {
    func showLoading() {
        loader.startAnimating()
        self.view.addSubview(loader)
    }
    
    func hideLoading() {
        loader.stopAnimating()
    }
    
    
}

extension UserListController : UserListDelegate {
    func renderView(viewModels: [UserViewModel]) {
        self.dataSource = UserDataSource(items : viewModels)
        userCollection.dataSource = self.dataSource
        userCollection.reloadData()
    }
}


extension UserListController : UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width : collectionView.frame.width,
                      height : 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected : ",indexPath.row)
    }
    
}




