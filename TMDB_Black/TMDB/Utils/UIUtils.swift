
import UIKit
import Foundation

extension UIImageView{
    
    func addBlackGradientLayer(frame: CGRect, colors:[UIColor]){
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x : 0,
                                y : 0,
                                width : frame.width,
                                height : frame.height)
        gradient.colors = colors.map{$0.cgColor}
        self.layer.addSublayer(gradient)
    }
    
    func addBlackGradientLayerSmall(frame : CGRect, colors : [UIColor]) {
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x : 0,
                                y : frame.height-100,
                                width : frame.width,
                                height : 100)
        gradient.colors = colors.map{$0.cgColor}
        self.layer.addSublayer(gradient)
    }
    
    func getBlackGradientLayer(frame: CGRect, colors:[UIColor]) -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x : 0,
                                y : frame.height-100,
                                width : frame.width,
                                height : 100)
        gradient.colors = colors.map{$0.cgColor}
        return gradient
    }
    
}


extension UICollectionViewCell {
    func addBlackGradientLayer(frame: CGRect, colors:[UIColor]){
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x : 0,
                                y : frame.height-80,
                                width : 200,
                                height : 80)
        gradient.colors = colors.map{$0.cgColor}
    }
}

class CustomHeightView: UIView {
    var height = 1.0
    
    override public var intrinsicContentSize: CGSize {
        return CGSize(width: 0.0, height: height)
    }
}
