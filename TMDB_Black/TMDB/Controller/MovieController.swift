import UIKit

class MovieController: UIViewController {
    
    
    @IBOutlet weak var movieCollection : UICollectionView!
    var segmentControl : UISegmentedControl
    
    var moviePresenter : MoviePresenter?
    var loadingIndicator : UIActivityIndicatorView?
    var movieArrayDataSource : MovieArrayDataSource?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        segmentControl = UISegmentedControl(items : ["Now","Popular","Top","Upcoming"])
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        segmentControl = UISegmentedControl(items : ["Now","Popular","Top","Upcoming"])
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeUI()
        moviePresenter?.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        movieCollection.reloadData()
    }
    
    override
    func viewWillAppear(_ animated: Bool) {
            self.navigationController?.navigationBar.topItem?.titleView = segmentControl
    }
    
    
    @objc func segmentedControlValueChanged() {
        let topOffest = CGPoint(x : 0,
                                y : 0)
        movieCollection.setContentOffset(topOffest, animated: false)
        moviePresenter?.callMovieApi(position: segmentControl.selectedSegmentIndex)


    }
    
    
    func initializeUI () {
        moviePresenter?.view = self
        movieCollection?.delegate = self
        
        loadingIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        loadingIndicator?.center = self.view.center
        loadingIndicator?.hidesWhenStopped = true
    }
}

extension MovieController : MovieProtocol {
    
    func initializeSegmentControl() {
        segmentControl.addTarget(self, action : #selector(self.segmentedControlValueChanged), for: .valueChanged)
        segmentControl.selectedSegmentIndex = 0
        
    }
    
    func add(movieViewModels: [MovieViewModel]) {
        movieArrayDataSource?.add(items: movieViewModels)
        movieCollection.reloadData()
    }
    
    func renderMovieList(movieViewModels: [MovieViewModel]) {
        self.movieArrayDataSource = MovieArrayDataSource(items : movieViewModels, view : self)
        movieCollection.dataSource = movieArrayDataSource
        movieCollection.reloadData()
    }
    
    
    func changeViewTitle(_ title : String) {
        //self.navigationController?.navigationBar.topItem?.title = title
    }
}

extension MovieController : LoaderProtocol {
    func showLoading() {
        loadingIndicator?.startAnimating()
        self.view.addSubview(loadingIndicator ?? UIActivityIndicatorView())
    }
    
    func hideLoading() {
        loadingIndicator?.stopAnimating()
    }
}

extension MovieController : ScrollProtocol {
    func didReachEnd() {
        moviePresenter?.loadMoreMovies(position: segmentControl.selectedSegmentIndex)
    }
    
    
}

extension MovieController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{

    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == movieCollection {
            return CGSize(width: collectionView.frame.width/2 - 2,
                height: self.view.frame.height/2 - 2)
        }
        return CGSize(width : 0,
                      height : 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let item = movieArrayDataSource?.itemAt(at: indexPath)  {
            moviePresenter?.movieSelected(movieViewModel: item)
        }
    }
    
}


