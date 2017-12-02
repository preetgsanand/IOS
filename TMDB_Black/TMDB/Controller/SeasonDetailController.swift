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
    var gradientLayer : CAGradientLayer?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        loader = UIActivityIndicatorView()
        loader.activityIndicatorViewStyle = .gray
        loader.hidesWhenStopped = true
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    

    
    required init?(coder aDecoder: NSCoder) {
        loader = UIActivityIndicatorView()
        loader.activityIndicatorViewStyle = .whiteLarge
        loader.hidesWhenStopped = true
        super.init(coder: aDecoder)
    }
    
    override
    func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.gradientLayer?.frame = seasonPoster.bounds
        episodeCollection.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGradientLayer()
        loader.center = self.view.center
        segmentedControl.layer.cornerRadius = 4
        segmentedControl.layer.masksToBounds = true
        presenter?.viewDidLoad()
        episodeCollection.delegate = self
    }
    
    func addGradientLayer() {
        let gradient = seasonPoster.getBlackGradientLayer(frame: seasonPoster.bounds, colors: [.clear,.black])
        self.seasonPoster.layer.addSublayer(gradient)
        self.gradientLayer = gradient
    }
    
    
    @IBAction func segmentedControlIndexChanged(sender : Any) {
        if segmentedControl.numberOfSegments > 5 {
            let collapsedWidth = Int(self.view.frame.width-110)/(segmentedControl.numberOfSegments-1)
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
        seasonPoster.image = UIImage(named : "placeholder")
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
                          height : 130)
        }
        else {
            return CGSize(width : 0,
                          height : 0)
        }
    }
}


