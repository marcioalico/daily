//
//  ViewController.swift
//  Daily
//
//  Created by Marcio Alico on 1/26/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var container: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.container.rounded()
    }

    @IBAction func goToRoulette(){
        let storyboard = UIStoryboard(name: "Roulette", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "RouletteViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

