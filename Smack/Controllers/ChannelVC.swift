//
//  ChannelVC.swift
//  Smack
//
//  Created by Ruhullah Rahimov on 12.01.21.
//

import UIKit

class ChannelVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController()?.rearViewRevealWidth = self.view.frame.size.width - 60
    }

}
