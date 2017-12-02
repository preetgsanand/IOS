import UIKit
import Nuke

class TvDetailController: UIViewController {

    
    var loadingIndicator : UIActivityIndicatorView?

    var presenter : TvDetailPresenter?
    var creditArrayDataSource : CreditArrayDataSource?
    var seasonArrayDataSource : SeasonArrayDataSource?
    
    @IBOutlet weak var backdropPoster : UIImageView!
    @IBOutlet weak var name : UILabel!
    @IBOutlet weak var vote : UILabel!
    @IBOutlet weak var overview : UILabel!
    @IBOutlet weak var seasonCollection : UICollectionView!
    @IBOutlet weak var castCollection : UICollectionView!
    @IBOutlet weak var seasonMore : UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.view = self
        seasonCollection.delegate = self
        castCollection.delegate = self
        presenter?.viewDidLoad()

    }
    
    func initializeLoadingIndicator() {
        loadingIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        loadingIndicator?.center = self.view.center
        loadingIndicator?.hidesWhenStopped = true
    }
    
    @IBAction func seasonMoreClicked(sender : Any) {
        if let seasons = seasonArrayDataSource?.provider.items {
            presenter?.seasonMoreClicked(seasons: seasons)
        }
    }

}

extension TvDetailController : LoaderProtocol {
    
    func showLoading() {
        if let loadingIndicator = self.loadingIndicator {
            loadingIndicator.startAnimating()
            self.view.addSubview(loadingIndicator)
        }
    }
    
    func hideLoading() {
        loadingIndicator?.stopAnimating()
    }
    
    
}

extension TvDetailController : TvDetailProtocol {
   
    
    func renderView(viewModel: TvDetailViewModel, castViewModels : [CastViewModel], seasonViewModels : [SeasonViewModel]) {
        name.text = viewModel.getTitle()
        vote.text = String(viewModel.vote_average)
        overview.text = viewModel.overview
        
        if let url = viewModel.getBackdropPosterUrl(), let backdrop = backdropPoster {
            Nuke.loadImage(with: url, into: backdrop)
            
        }
        
        self.seasonArrayDataSource = SeasonArrayDataSource(items : seasonViewModels, view : nil)
        self.creditArrayDataSource = CreditArrayDataSource(items : castViewModels, view : nil)
        
        seasonCollection.dataSource = seasonArrayDataSource
        castCollection.dataSource = creditArrayDataSource
        seasonCollection?.reloadData()
        castCollection?.reloadData()
    }
    
    func setTitle(title : String) {
        self.title = title
    }
}

extension TvDetailController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == seasonCollection {
            return CGSize(width: collectionView.frame.width/3 - 8,
                          height: collectionView.frame.width/3 - 8)
        }
        if collectionView == castCollection {
            return CGSize(width: collectionView.frame.width/3 - 8,
                          height: collectionView.frame.width/3 - 8)
        }
        return CGSize(width : 0,
                      height : 0)
    }
}


class SeasonArrayDataSource : CollectionDataSource<SeasonViewModel, SeasonCell> {
    
}

class CreditArrayDataSource : CollectionDataSource<CastViewModel, CreditCell> {
    
}
