import UIKit
import Nuke

class BoardCell: UICollectionViewCell {
    
    @IBOutlet weak var name : UILabel!
    @IBOutlet weak var backgroundImage : UIImageView!
    @IBOutlet weak var dateSinceActivity : UILabel!

    
    func updateView(board : Board) {
        self.backgroundImage.layer.cornerRadius = 5
        self.backgroundImage.layer.masksToBounds = true
        
        
        name?.text = board.name
        dateSinceActivity?.text = "Last Activity : "+dateToReadableDateTime(date: board.dateLastActivity)
        
        if board.backgroundImage != ""{
            if let url = URL(string : board.backgroundImage), let backgroundImage = self.backgroundImage {
                Nuke.loadImage(with: url, into: backgroundImage)
            }
        }
        else {
            self.backgroundImage.backgroundColor = hexStringToUIColor(hex: board.backgroundColor)
        }
        
    }

}
