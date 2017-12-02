//
//  ViewController.swift
//  app_one
//
//  Created by Preet G S Anand on 10/11/17.
//  Copyright © 2017 Preet G S Anand. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    //UI
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var clickButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    @IBAction func clickButtonPressed(_ sender: UIButton) {
        backgroundImage.isHidden = true;
    }
    

}

