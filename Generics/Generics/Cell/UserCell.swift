

import UIKit

class UserCell: UICollectionViewCell, ConfigurableCell {
    
    static var reuseIndentifier: String = "UserCell"
    
    
    
    @IBOutlet weak var name : UILabel!
    @IBOutlet weak var designation : UILabel!
    @IBOutlet weak var image : UIImageView!
    

    func configure(_ item: UserViewModel) {
        name?.text = item.getCleanName()
        designation?.text = item.getCleanDesignation()
        image?.image = UIImage(named : "user")
    }

}
