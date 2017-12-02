import UIKit
import Nuke

class MovieCell: UICollectionViewCell, ConfigurableCell{
    static var reusableIdentifier: String = "MovieCell"
    
    typealias T = MovieViewModel
    
    
    
    @IBOutlet weak var name : UILabel!
    @IBOutlet weak var rating : UILabel!
    @IBOutlet weak var poster : UIImageView!
    var gradientLayer : CAGradientLayer?
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let gradient = poster?.getBlackGradientLayer(frame: self.bounds, colors: [.clear, .black])
        self.poster.layer.addSublayer(gradient ?? CAGradientLayer())
        self.gradientLayer = gradient
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.gradientLayer?.frame = CGRect(x : 0,
                                           y : frame.height-100,
                                           width : frame.width,
                                           height : 100)
    }
    
    
    func configure(_ item: MovieViewModel) {
        poster?.image = UIImage(named : "placeholder")
        self.layer.cornerRadius = 3
        self.layer.masksToBounds = true
        
        
        name?.text = item.getMovieTitle()
        rating?.text = String(item.vote_average)
        if let url = item.getPosterUrl(), let poster = poster {
            Nuke.loadImage(with: url, into: poster)
        }

    }
    
}
