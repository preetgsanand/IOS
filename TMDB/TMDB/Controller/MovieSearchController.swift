import UIKit

class MovieSearchController: UIViewController {

    @IBOutlet weak var movieCollection : UICollectionView!
    @IBOutlet weak var segmentedControl : UISegmentedControl!
    
    var movieSearchPresenter : MovieSearchPresenter?
    var loadingIndicator : UIActivityIndicatorView?
    var movieArrayDataSource : MovieArrayDataSource?
    var tvArrayDataSource : TvArrayDataSource?
    var searchBar : UISearchBar
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        searchBar = UISearchBar()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        searchBar = UISearchBar()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieSearchPresenter?.viewDidLoad()
    }
    
    
    override
    func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.titleView = searchBar
        searchBar.heightAnchor.constraint(equalToConstant: 44).isActive = true
        searchBar.becomeFirstResponder()
        searchBar.delegate = self
    }
    
    func initializeParameters() {
        movieCollection.delegate = self
        
        loadingIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        loadingIndicator?.center = self.view.center
        loadingIndicator?.hidesWhenStopped = true
    }
    
    @IBAction func segmentedControlValueChanged(_ sender : Any) {
        if let query = searchBar.text {
            movieSearchPresenter?.queryEntered(query: query, position: segmentedControl.selectedSegmentIndex)
        }
    }
    
}
extension MovieSearchController : SearchProtocol, UISearchBarDelegate {
    func renderTvList(tvViewModels: [TvViewModel]) {
        self.tvArrayDataSource = TvArrayDataSource(items : tvViewModels, view : self)
        movieCollection.dataSource = self.tvArrayDataSource
        movieCollection.reloadData()
    }
    
    func add(tvViewModel: [TvViewModel]) {
        self.tvArrayDataSource?.add(items: tvViewModel)
        movieCollection.reloadData()
    }
    
    
    func add(movieViewModels: [MovieViewModel]) {
        movieArrayDataSource?.add(items: movieViewModels)
        movieCollection.reloadData()
    }
    
    func removeAll(position : Int) {
        switch position {
        case 0:
            movieArrayDataSource?.removeAll()
            break
        case 1:
            tvArrayDataSource?.removeAll()
            break
        default:
            print("-- Default Remove All ---")
        }
        movieCollection.reloadData()
    }
    
    func renderMovieList(movieViewModels: [MovieViewModel]) {
        self.movieArrayDataSource = MovieArrayDataSource(items : movieViewModels, view : self)
        movieCollection.dataSource = movieArrayDataSource
        movieCollection.reloadData()
    }
    
   
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let query = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
            movieSearchPresenter?.queryEntered(query: query, position: segmentedControl.selectedSegmentIndex)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
    
}

extension MovieSearchController : ScrollProtocol {
    func didReachEnd() {
        if let query = searchBar.text{
            movieSearchPresenter?.loadMoreMovies(query: query, position: segmentedControl.selectedSegmentIndex)
        }
    }
}

extension MovieSearchController : LoaderProtocol {
    func showLoading() {
        loadingIndicator?.startAnimating()
        self.view.addSubview(loadingIndicator ?? UIActivityIndicatorView())
    }
    
    func hideLoading() {
        loadingIndicator?.stopAnimating()
    }
}


extension MovieSearchController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
  
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == movieCollection {
            return CGSize(width: collectionView.frame.width/3-2,
                          height: collectionView.frame.height/3-2)
        }
        return CGSize(width : 0,
                      height : 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (movieCollection.dataSource?.isKind(of: MovieArrayDataSource.self))! {
            if let item = movieArrayDataSource?.itemAt(at: indexPath) {
                movieSearchPresenter?.movieSelected(movieViewModel: item)
            }
        }
        else {
            if let item = tvArrayDataSource?.itemAt(at: indexPath) {
                movieSearchPresenter?.tvSelected(tvViewModel: item)
            }
        }
    }
    
    
}


