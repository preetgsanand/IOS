import UIKit
import Nuke

class TvDetailController: UIViewController {

    
    var loadingIndicator : UIActivityIndicatorView

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
    
    @IBOutlet weak var seasonStackView : CustomHeightView!
    @IBOutlet weak var castStackView : CustomHeightView!

    var gradientLayer : CAGradientLayer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.view = self
        seasonCollection.delegate = self
        castCollection.delegate = self
        loadingIndicator.center = self.view.center
        seasonStackView.height = 2
        castStackView.height = 3
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.gradientLayer?.frame = backdropPoster.bounds

        changeSeasonFlowDirection()
        castCollection.reloadData()
        seasonCollection.reloadData()
        
    }

    func changeSeasonFlowDirection() {
        if let flowLayout = seasonCollection.collectionViewLayout as? UICollectionViewFlowLayout {
            if UIDevice.current.orientation == UIDeviceOrientation.landscapeRight || UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft {
                flowLayout.scrollDirection = .vertical
            }
            else {
                flowLayout.scrollDirection = .horizontal
            }
        }
    }
    
    @IBAction func seasonMoreClicked(sender : Any) {
        if let seasons = seasonArrayDataSource?.provider.items {
            presenter?.seasonMoreClicked(seasons: seasons)
        }
    }

}

extension TvDetailController : LoaderProtocol {
    
    func showLoading() {
        loadingIndicator.startAnimating()
        self.view.addSubview(loadingIndicator)
    }
    
    func hideLoading() {
        loadingIndicator.stopAnimating()
    }

    
    
}

extension TvDetailController : TvDetailProtocol {
   
    
    func renderView(viewModel: TvDetailViewModel, castViewModels : [CastViewModel], seasonViewModels : [SeasonViewModel]) {
        
        let gradient = backdropPoster.getBlackGradientLayer(frame: backdropPoster.bounds, colors: [.clear,.black])
        self.backdropPoster.layer.addSublayer(gradient)
        self.gradientLayer = gradient
        
        backdropPoster.image = UIImage(named : "placeholder")
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
        changeSeasonFlowDirection()
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
                          height: collectionView.frame.width/3 + 12)
        }
        return CGSize(width : 0,
                      height : 0)
    }
}


class SeasonArrayDataSource : CollectionDataSource<SeasonViewModel, SeasonCell> {
    
}

class CreditArrayDataSource : CollectionDataSource<CastViewModel, CreditCell> {
    
}
