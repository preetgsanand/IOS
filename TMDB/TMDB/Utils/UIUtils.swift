//
//  UIUtils.swift
//  TMDB
//
//  Created by Preet G S Anand on 11/20/17.
//  Copyright © 2017 Preet G S Anand. All rights reserved.
//
import UIKit
import Foundation

extension UIImageView{
    func addBlackGradientLayer(frame: CGRect, colors:[UIColor]){
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.colors = colors.map{$0.cgColor}
        self.layer.addSublayer(gradient)
    }
}
