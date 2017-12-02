
import UIKit
import Nuke

class TvCell: UICollectionViewCell, ConfigurableCell {
    static var reusableIdentifier: String = "TvCell"
    
    typealias T = TvViewModel
    
    
    @IBOutlet weak var name : UILabel?
    @IBOutlet weak var backdropPoster : UIImageView?
    @IBOutlet weak var vote : UILabel?
    var gradientLayer : CAGradientLayer?
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let gradient = backdropPoster?.getBlackGradientLayer(frame: self.bounds, colors: [.clear, .black])
        self.backdropPoster?.layer.addSublayer(gradient ?? CAGradientLayer())
        self.gradientLayer = gradient
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.gradientLayer?.frame = CGRect(x : 0,
                                           y : frame.height-100,
                                           width : frame.width,
                                           height : 100)
        self.backdropPoster?.layer.cornerRadius = 3
        self.backdropPoster?.layer.masksToBounds = true
    }
    
    
    
    func configure(_ item: TvViewModel) {
        backdropPoster?.image = UIImage(named : "placeholder")
        name?.text = item.getTitle()
        vote?.text = String(item.vote_average)
        
        if let url = item.getBackdropPosterUrl(), let backdropPoster = self.backdropPoster{
            Nuke.loadImage(with: url, into: backdropPoster)
        }
    }
}
