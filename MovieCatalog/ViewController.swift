//
//  ViewController.swift
//  MovieCatalog
//
//  Created by Bruno Maciel on 2/24/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func tapButton(_ sender: UIButton) {
        let homeCoordinator = HomeCoordinator()
        homeCoordinator.start(from: self)
    }

}
