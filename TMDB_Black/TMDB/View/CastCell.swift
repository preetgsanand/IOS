import UIKit
import Nuke

class PeopleDetailCreditCell : UICollectionViewCell, ConfigurableCell {
    
    static var reusableIdentifier: String = "PeopleDetailCreditCell"
    
    @IBOutlet weak var poster : UIImageView!
    @IBOutlet weak var title : UILabel!
    @IBOutlet weak var character : UILabel!
    @IBOutlet weak var date : UILabel!
    
    
    func configure(_ item: PeopleCreditViewModel) {
        poster.image = UIImage(named : "placeholder")
        poster.layer.cornerRadius = 3
        poster.layer.masksToBounds = true
        
        title.text = item.title
        date.text = DateUtils.dateToReadableFormat(date: item.release_date)
        character.text = item.getCharacter()
        
        if let poster = poster, let url = item.getUrl() {
            Nuke.loadImage(with: url, into: poster)
        }
    }
    
    
}

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
