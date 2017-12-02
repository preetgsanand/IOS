import UIKit

class ListCell : UITableViewCell, ConfigurableCell {
    
    static var reusableIdentifier = "ListCell"
    

    @IBOutlet weak var collectionView : UICollectionView!
    @IBOutlet weak var title : UILabel!
    
    var genreDataSource : GenreDataSource?
    var movieDataSource : MovieArrayDataSource?
    var tvDataSource : TvArrayDataSource?
    var view : HomeListCellProtocol?

    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    func configure(_ item: ListViewModel) {
        collectionView.delegate = self
        title.text = item.title
        constructDataSource(identifier: item.identifier, items: item.items)
        collectionView.reloadData()
    }
    
    func constructDataSource(identifier : String, items : [Any]) {
        switch identifier {
        case "Genre":
            if let genreViewModels = items as? [GenreViewModel] {
                let dataSource = GenreDataSource(items : genreViewModels, view: nil)
                collectionView.dataSource = dataSource
                self.genreDataSource = dataSource
                
            }
            break;
        case "Movie" :
            if let movieViewModels = items as? [MovieViewModel] {
                let dataSource = MovieArrayDataSource(items : movieViewModels, view: nil)
                collectionView.dataSource = dataSource
                self.movieDataSource = dataSource
                
            }
            break;
        case "Tv" :
            if let tvViewModels = items as? [TvViewModel] {
                let dataSource = TvArrayDataSource(items : tvViewModels, view: nil)
                collectionView.dataSource = dataSource
                self.tvDataSource = dataSource
                
            }
            break;
        default:
            print()
        }
    }
}

extension ListCell : UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width : collectionView.frame.height-30,
                      height : collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let dataSource = collectionView.dataSource as? GenreDataSource {
            if let genreViewModel = dataSource.itemAt(at: indexPath) {
                view?.genreSelected(viewModel: genreViewModel)
            }
        }
        else if let dataSource = collectionView.dataSource as? MovieArrayDataSource {
            if let movieViewModel = dataSource.itemAt(at: indexPath) {
                view?.movieSelected(viewModel: movieViewModel)
            }
        }
        else if let dataSource = collectionView.dataSource as? TvArrayDataSource {
            if let tvViewModel = dataSource.itemAt(at: indexPath) {
                view?.tvSelected(viewModel: tvViewModel)
            }
        }
    }
}



