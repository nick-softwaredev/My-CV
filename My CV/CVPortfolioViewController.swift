//
//  CVPortfolioViewController.swift
//  My CV
//
//  Created by Nick Nick  on 4/28/19.
//  Copyright © 2019 IndieApps. All rights reserved.
//

import UIKit

class CVPortfolioViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        rightSwipe.direction = .down
        view.addGestureRecognizer(rightSwipe)
        
        // Do any additional setup after loading the view.
    }
    
    @objc func handleSwipes(_ sender:UISwipeGestureRecognizer)
    {
         dismiss(animated: true, completion: nil)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
