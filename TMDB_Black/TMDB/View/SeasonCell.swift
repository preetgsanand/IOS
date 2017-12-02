import UIKit
import Nuke

class SeasonCell: UICollectionViewCell, ConfigurableCell {
    static var reusableIdentifier: String = "SeasonCell"
    
    typealias T = SeasonViewModel
    

    @IBOutlet weak var details : UILabel!
    @IBOutlet weak var poster : UIImageView!
    
    func configure(_ item: SeasonViewModel) {
        poster.layer.cornerRadius = min(frame.height/2-15, frame.width/2-15)
        poster.layer.masksToBounds = true
        poster.image = UIImage(named : "placeholder")
        details.text = item.getDetails()
        
        if let url = item.getPosterUrl(), let poster = poster {
            Nuke.loadImage(with: url, into: poster)
        }
    }
}
