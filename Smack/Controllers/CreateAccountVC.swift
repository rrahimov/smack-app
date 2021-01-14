//
//  CreateAccountVC.swift
//  Smack
//
//  Created by Ruhullah Rahimov on 14.01.21.
//

import UIKit

class CreateAccountVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func closePressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil
        )
    }
    
}
