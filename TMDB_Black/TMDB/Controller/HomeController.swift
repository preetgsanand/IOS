

import UIKit

class HomeController: UIViewController {

    @IBOutlet weak var listTableView : UITableView!
    
    var dataSource : ListArrayDataSource?
    var loader : UIActivityIndicatorView
    var presenter : HomePresenter?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        loader = UIActivityIndicatorView()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        loader = UIActivityIndicatorView()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        listTableView.reloadData()
    }
    
    func initializeParameters() {
        dataSource = ListArrayDataSource(items : [ListViewModel](), view : self)
        listTableView.estimatedRowHeight = self.view.frame.height/3
        loader.activityIndicatorViewStyle = .whiteLarge
        loader.hidesWhenStopped = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let title = UILabel()
        title.text = "Home"
        title.textColor = UIColor.white
        self.navigationController?.navigationBar.topItem?.titleView = title
    }
}

extension HomeController : LoaderProtocol {
    func showLoading() {
        loader.startAnimating()
        loader.center = self.view.center
        self.view.addSubview(loader)
    }
    
    func hideLoading() {
        loader.stopAnimating()
    }
}

extension HomeController : HomeProtocol {
    func renderListViewModel(listViewModel: ListViewModel) {
        dataSource?.add(item: [listViewModel])
        listTableView.dataSource = self.dataSource
        listTableView.reloadData()
    }
}

extension HomeController : HomeListCellProtocol {
    func genreSelected(viewModel: GenreViewModel) {
        presenter?.genreSelected(genreViewModel: viewModel)
    }
    
    func movieSelected(viewModel: MovieViewModel) {
        presenter?.movieSelected(movieViewModel: viewModel)
    }
    
    func tvSelected(viewModel: TvViewModel) {
        presenter?.tvSelected(tvViewModel: viewModel)
    }
    
    
}




