
import UIKit
import Nuke

class TvCell: UICollectionViewCell, ConfigurableCell {
    static var reusableIdentifier: String = "TvCell"
    
    typealias T = TvViewModel
    
    
    @IBOutlet weak var name : UILabel?
    @IBOutlet weak var backdropPoster : UIImageView?
    @IBOutlet weak var vote : UILabel?
    
    
    func configure(_ item: TvViewModel) {
        backdropPoster?.image = UIImage(named : "placeholder")
        name?.text = item.getTitle()
        vote?.text = String(item.vote_average)
        
        if let url = item.getBackdropPosterUrl(), let backdropPoster = self.backdropPoster{
            Nuke.loadImage(with: url, into: backdropPoster)
        }
    }
}
