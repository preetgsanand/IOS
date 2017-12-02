import UIKit

class GenreCell: UICollectionViewCell, ConfigurableCell {
    static var reusableIdentifier: String = "GenreCell"
    
    
    
    @IBOutlet weak var poster : UIImageView!
    @IBOutlet weak var title : UILabel!
//
//    var gradientLayer : CAGradientLayer?
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        let gradient = poster?.getBlackGradientLayer(frame: poster.bounds, colors: [.clear, .black])
//        self.poster.layer.addSublayer(gradient ?? CAGradientLayer())
//        self.gradientLayer = gradient
//    }
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        self.gradientLayer?.frame = poster.b
//    }

    func configure(_ item: GenreViewModel) {
        poster.layer.cornerRadius = 3
        poster.layer.masksToBounds = true
        title.text = item.title
        poster.image = UIImage(named : item.imageName)
    }
}
