import UIKit
import Nuke

class CreditCell : UICollectionViewCell, ConfigurableCell {
    static var reusableIdentifier: String = "CreditCell"
    
    typealias T = CastViewModel
    
    
    @IBOutlet weak var profileImage : UIImageView!
    @IBOutlet weak var details : UILabel!
    
    
    func configure(_ item: CastViewModel) {
        profileImage.layer.cornerRadius = min(frame.height/2-15, frame.width/2-15)
        profileImage.layer.masksToBounds = true
        profileImage?.image = UIImage(named : "placeholder")
        details?.text = item.getDetails()
        if let url = item.getUrl(), let profileImage = profileImage {
            Nuke.loadImage(with: url, into: profileImage)
        }
    }

}
