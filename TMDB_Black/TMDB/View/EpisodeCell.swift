import UIKit
import Nuke

class EpisodeCell: UICollectionViewCell, ConfigurableCell{
    static var reusableIdentifier: String = "EpisodeCell"
    
    @IBOutlet weak var name : UILabel!
    @IBOutlet weak var poster : UIImageView!
    @IBOutlet weak var episode_number : UILabel!
    @IBOutlet weak var overview : UILabel!
    @IBOutlet weak var air_date : UILabel!
    @IBOutlet weak var vote_average : UILabel!
    
    func configure(_ item: EpisodeViewModel) {
        poster.image = UIImage(named : "placeholder")
        poster.layer.cornerRadius = 5
        poster.layer.masksToBounds = true
        name.text = item.name
        episode_number.text = "#"+String(item.episode_number)
        overview.text = item.overview
        air_date.text = item.getDate()
        vote_average.text = String(item.vote_average)
        if let url = item.getStillUrl(), let image = poster {
            Nuke.loadImage(with: url, into: image)
        }
    }
    
}
