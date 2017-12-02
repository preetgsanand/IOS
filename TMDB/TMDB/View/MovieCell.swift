import UIKit
import Nuke

class MovieCell: UICollectionViewCell, ConfigurableCell{
    static var reusableIdentifier: String = "MovieCell"
    
    typealias T = MovieViewModel
    
    
    
    @IBOutlet weak var name : UILabel!
    @IBOutlet weak var rating : UILabel!
    @IBOutlet weak var poster : UIImageView!
    
    
    func configure(_ item: MovieViewModel) {
        poster?.image = UIImage(named : "placeholder")
        self.layer.cornerRadius = 3
        self.layer.masksToBounds = true
        
        
        name?.text = item.title
        rating?.text = String(item.vote_average)
        if let url = item.getPosterUrl(), let poster = poster {
            Nuke.loadImage(with: url, into: poster)
        }
    }
    
    
    func updateView(movie : Movie) {
        
    }
}
