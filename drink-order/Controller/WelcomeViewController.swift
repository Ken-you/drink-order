//
//  welcomeViewController.swift
//  drink-order
//
//  Created by yousun on 2021/5/25.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // 上方的 NavigationBar 隱藏
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        // Button 動畫
        UIButton.animate(withDuration: 1.5) {
            self.startButton.frame.origin.y -= 200
            self.startButton.alpha = 1
            self.startButton.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            }
    }
}
