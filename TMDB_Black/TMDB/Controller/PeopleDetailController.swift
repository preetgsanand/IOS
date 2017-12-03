import UIKit
import Nuke

class PeopleDetailController: UIViewController {

    var loadingIndicator : UIActivityIndicatorView!
    var presenter : PeopleDetailPresenter?
    var dataSource : PeopleCreditDataSource?
    
    @IBOutlet weak var poster : UIImageView!
    @IBOutlet weak var name : UILabel!
    @IBOutlet weak var detail : UILabel!
    @IBOutlet weak var biography : UILabel!
    @IBOutlet weak var collection : UICollectionView!
    
    @IBOutlet weak var detailCustomView : CustomHeightView!
    @IBOutlet weak var creditCusomtView : CustomHeightView!


    override func viewDidLoad() {
        super.viewDidLoad()
        loadingIndicator.center = self.view.center
        detailCustomView.height = 1
        creditCusomtView.height = 2
        collection.delegate = self
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
    
    override
    func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
         collection.reloadData()
    }
    
}

extension PeopleDetailController : LoaderProtocol {
    
    func showLoading() {
        loadingIndicator.startAnimating()
        self.view.addSubview(loadingIndicator)
    }
    
    func hideLoading() {
        loadingIndicator.stopAnimating()
    }
    
    
}

extension PeopleDetailController : PeopleDetailProtocol {
    
    func renderView(_ peopleDetailViewModel: PeopleDetailViewModel, _ creditViewModels: [PeopleCreditViewModel]) {
        poster.layer.cornerRadius = 3
        poster.layer.masksToBounds = true
        poster.image = UIImage(named : "placeholder")
        let dataSource = PeopleCreditDataSource(items : creditViewModels, view : nil)
        collection.dataSource = dataSource
        collection.reloadData()
        self.dataSource = dataSource
        
        name.text = peopleDetailViewModel.name
        biography.text = peopleDetailViewModel.biography
        detail.text = peopleDetailViewModel.getBirthDetails()
        
        if let poster = poster, let url = peopleDetailViewModel.getUrl() {
           Nuke.loadImage(with: url, into: poster)
        }
    }
    
    
}

extension PeopleDetailController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width : collection.frame.width,
            height : 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let viewModel = dataSource?.itemAt(at: indexPath) {
            presenter?.movieSelected(id: viewModel.id)
        }
    }
}


