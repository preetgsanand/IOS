import UIKit

class TvController: UIViewController {
    
    var loadingIndicator : UIActivityIndicatorView
    var presenter : TvPresenter?
    var tvDataSource : TvArrayDataSource?
    var segmentedControl : UISegmentedControl
    
    @IBOutlet weak var tvCollection : UICollectionView!
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        segmentedControl = UISegmentedControl(items : ["Today","On Air","Popular","Top"])
        loadingIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        segmentedControl = UISegmentedControl(items : ["Today","On Air","Popular","Top"])
        loadingIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tvCollection.delegate = self
        presenter?.viewDidLoad()
    }
    
    override
    func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.titleView = segmentedControl
    }
    
    func initializeLoadingIndicator() {
        
        loadingIndicator.center = self.view.center
        loadingIndicator.hidesWhenStopped = true
    }
    
    @objc
    func segmentedControlValueChanged() {
        presenter?.callTvApi(position: segmentedControl.selectedSegmentIndex)
        let topOffest = CGPoint(x : 0,
                                y : 0)
        tvCollection?.setContentOffset(topOffest, animated: true)
    }
    


}

extension TvController : TvProtocol {
    func add(tvViewModels: [TvViewModel]) {
        tvDataSource?.add(items: tvViewModels)
        tvCollection.reloadData()
    }
    
    func renderTvList(viewModels: [TvViewModel]) {
        self.tvDataSource = TvArrayDataSource(items : viewModels, view : self)
        tvCollection.dataSource = self.tvDataSource
        tvCollection.reloadData()
    }
    
    func initializeSegmentControl() {
        segmentedControl.addTarget(self, action : #selector(self.segmentedControlValueChanged), for: .valueChanged)
        segmentedControl.selectedSegmentIndex = 0
        
    }
    
}

extension TvController : ScrollProtocol {
    func didReachEnd() {
        print("Reached End - Controller")
        presenter?.loadMoreTvs(position: segmentedControl.selectedSegmentIndex)
    }
    
    
}

extension TvController : LoaderProtocol {
    func showLoading() {
            loadingIndicator.startAnimating()
            self.view.addSubview(loadingIndicator)
    }
    
    func hideLoading() {
        loadingIndicator.stopAnimating()
    }
}

class TvArrayDataSource : CollectionDataSource<TvViewModel, TvCell> {
    
}

extension TvController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == tvCollection {
            return CGSize(width: collectionView.frame.width-2,
                          height: self.view.frame.height/3 - 2)
        }
        return CGSize(width : 0,
                      height : 0)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let item = tvDataSource?.itemAt(at: indexPath) {
            presenter?.tvSelected(tvViewModel: item)
        }
    }



}

