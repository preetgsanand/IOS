//
//  BorderButton.swift
//  app-swoosh
//
//  Created by Preet G S Anand on 10/11/17.
//  Copyright © 2017 Preet G S Anand. All rights reserved.
//

import UIKit

class BorderButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib();
        layer.borderWidth = 1.0;
        layer.borderColor = UIColor.white.cgColor;
    }

}
