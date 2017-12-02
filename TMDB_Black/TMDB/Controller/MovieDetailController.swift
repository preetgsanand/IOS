
import UIKit
import Nuke

class MovieDetailController: UIViewController{
   
    

    @IBOutlet weak var castCollection : UICollectionView!
    
    @IBOutlet weak var moviePoster : UIImageView!
    @IBOutlet weak var movieTitle : UILabel!
    @IBOutlet weak var movieGenres : UILabel!
    @IBOutlet weak var movieOverview : UILabel!
    @IBOutlet weak var movieRating : UILabel!

    var loadingIndicator : UIActivityIndicatorView?
    var movieDetailPresenter : MovieDetailPresenter?
    var creditArrayDataSource : CreditArrayDataSource?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeParameters()
        movieDetailPresenter?.viewDidLoad()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        castCollection.reloadData()
    }
    
    func initializeParameters() {
        movieDetailPresenter?.view = self
        castCollection?.delegate = self
        
        loadingIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        loadingIndicator?.center = self.view.center
        loadingIndicator?.hidesWhenStopped = true
    }

}

extension MovieDetailController : MovieDetailProtocol {
    func renderView(_ movieDetailViewModel: MovieDetailViewModel, castViewModels: [CastViewModel]) {
        moviePoster.image = UIImage(named : "placeholder")
        movieTitle?.text = movieDetailViewModel.getMovieTitle()
        movieOverview?.text = movieDetailViewModel.overview
        movieRating?.text = String(movieDetailViewModel.vote_average)
        movieGenres?.text = movieDetailViewModel.getGenreString()
        
        if let url = movieDetailViewModel.getPosterUrl(), let poster = moviePoster {
            Nuke.loadImage(with: url, into: poster)
        }
        
        self.creditArrayDataSource = CreditArrayDataSource(items : castViewModels, view : nil)
        castCollection.dataSource = self.creditArrayDataSource
        castCollection.reloadData()
    }

    
    func setTitle(title : String) {
        self.title = title
    }
    
}

extension MovieDetailController : LoaderProtocol {
    
    func showLoading() {
        loadingIndicator?.startAnimating()
        self.view.addSubview(loadingIndicator ?? UIActivityIndicatorView())
    }
    
    func hideLoading() {
        loadingIndicator?.stopAnimating()
    }
    
}


extension MovieDetailController : UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.castCollection {
            return CGSize(width : collectionView.frame.width/3 - 8,
                          height : collectionView.frame.width/3 + 12);
        }
        else {
            return CGSize(width : 0,
                          height : 0);
        }
    }
    
}
