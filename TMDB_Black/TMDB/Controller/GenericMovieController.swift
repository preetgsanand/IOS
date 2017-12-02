import UIKit

class GenericMovieController: UIViewController {

    var loadingIndicator : UIActivityIndicatorView
    var dataSource : MovieArrayDataSource?
    var presenter : GenericMoviePresenter?
    
    @IBOutlet weak var collectionView : UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadingIndicator.center = self.view.center
        collectionView.delegate = self  
        presenter?.viewDidLoad()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        loadingIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        loadingIndicator.hidesWhenStopped = true
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        loadingIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        loadingIndicator.hidesWhenStopped = true
        super.init(coder: aDecoder)
    }
    
    
}

extension GenericMovieController : LoaderProtocol {
    func showLoading() {
        loadingIndicator.startAnimating()
        self.view.addSubview(loadingIndicator)
    }
    
    func hideLoading() {
        loadingIndicator.stopAnimating()
    }
    
    
}

extension GenericMovieController : ScrollProtocol {
    func didReachEnd() {
        
    }
}

extension GenericMovieController : MovieProtocol {
    func renderMovieList(movieViewModels: [MovieViewModel]) {
        print(movieViewModels.count)
        let dataSource = MovieArrayDataSource(items : movieViewModels, view : self)
        collectionView.dataSource = dataSource
        self.dataSource = dataSource
        collectionView.reloadData()
    }
    
    func changeViewTitle(_ title: String) {
        self.navigationController?.navigationBar.topItem?.title = title
    }
    
    func add(movieViewModels: [MovieViewModel]) {
        self.dataSource?.add(items: movieViewModels)
        collectionView.reloadData()
    }
    
    func initializeSegmentControl() {
        
    }
}

extension GenericMovieController : UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2 - 2,
                      height: self.view.frame.height/2 - 2)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let item = dataSource?.itemAt(at: indexPath)  {
            presenter?.movieSelected(movieViewModel: item)
        }
    }
}
