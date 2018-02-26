//
//  TabViewController.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class TabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    public static func storyboardINstance() -> TabViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabViewController = storyboard.instantiateViewController(withIdentifier: "TabViewController") as! TabViewController
        return tabViewController
    }
}
