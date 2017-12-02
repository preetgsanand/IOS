//
//  ViewController.swift
//  app-swoosh
//
//  Created by Preet G S Anand on 10/11/17.
//  Copyright © 2017 Preet G S Anand. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var mainView: UIView!
    @IBOutlet weak var swooshLogo: UIImageView!
    @IBOutlet weak var backgroundImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setUI()
    }
    
    func setUI() {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

