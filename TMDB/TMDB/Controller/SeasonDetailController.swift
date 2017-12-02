import UIKit
import Nuke

class SeasonDetailController: UIViewController {

    @IBOutlet weak var segmentedControl : UISegmentedControl!
    @IBOutlet weak var seasonPoster : UIImageView!
    @IBOutlet weak var seasonName : UILabel!
    @IBOutlet weak var episodeCollection : UICollectionView!
    
    var presenter : SeasonDetailPresenter?
    var loader : UIActivityIndicatorView
    var episodeArrayDataSource : EpisodeDataSource?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        loader = UIActivityIndicatorView()
        loader.activityIndicatorViewStyle = .gray
        loader.hidesWhenStopped = true
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        loader = UIActivityIndicatorView()
        loader.activityIndicatorViewStyle = .gray
        loader.hidesWhenStopped = true
        super.init(coder: aDecoder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentedControl.layer.cornerRadius = 4
        segmentedControl.layer.masksToBounds = true
        seasonPoster.addBlackGradientLayer(frame: seasonPoster.bounds, colors: [.clear, .black])
        presenter?.viewDidLoad()
        episodeCollection.delegate = self
    }
    
    @IBAction func segmentedControlIndexChanged(sender : Any) {
        if segmentedControl.numberOfSegments > 5 {
            let collapsedWidth = Int(self.view.frame.width-115)/(segmentedControl.numberOfSegments-1)
            for i in 0..<segmentedControl.numberOfSegments {
                if i == segmentedControl.selectedSegmentIndex {
                    segmentedControl.setWidth(100, forSegmentAt: i)
                }
                else {
                    segmentedControl.setWidth(CGFloat(collapsedWidth), forSegmentAt: i)
                }
            }
        }
        presenter?.callSeasonDetailApi(position: segmentedControl.selectedSegmentIndex)
        
    }

}

extension SeasonDetailController : SeasonDetailProtocol {
    
    func renderSeasonDetail(seasonViewModel: SeasonDetailViewModel, episodeViewModels : [EpisodeViewModel]) {
        seasonName.text = seasonViewModel.getName()
        if let url = seasonViewModel.getPosterUrl(), let image = seasonPoster {
            Nuke.loadImage(with: url, into: image)
            
        }
        
        episodeArrayDataSource = EpisodeDataSource(items : episodeViewModels, view : nil)
        episodeCollection.dataSource = episodeArrayDataSource
        episodeCollection.reloadData()
        
    }
    
   

    func initializeSegments(seasonViewModels: [SeasonViewModel]) {
        segmentedControl.removeAllSegments()
        for i in 0..<seasonViewModels.count {
            segmentedControl.insertSegment(withTitle: seasonViewModels[i].getDetails(), at: i, animated: true)
        }
        segmentedControl.selectedSegmentIndex = 0
        segmentedControlIndexChanged(sender: segmentedControl)
    }
}



extension SeasonDetailController : LoaderProtocol {
    func showLoading() {
        loader.startAnimating()
        self.view.addSubview(loader)
    }
    
    
    func hideLoading() {
        loader.stopAnimating()
    }
}

extension SeasonDetailController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == episodeCollection {
            return CGSize(width : collectionView.frame.width,
                          height : collectionView.frame.height/4-2)
        }
        else {
            return CGSize(width : 0,
                          height : 0)
        }
    }
}


class EpisodeDataSource : CollectionDataSource<EpisodeViewModel, EpisodeCell> {
    
}
