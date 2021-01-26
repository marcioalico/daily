//
//  AtomosViewController.swift
//  Daily
//
//  Created by Marcio Alico on 1/26/21.
//

import Foundation
import UIKit
import AVFoundation

class AtomosViewController: UIViewController {
    
    @IBOutlet weak var videoView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        play()
    }
    
    func play() {
        guard let path = Bundle.main.path(forResource: "darle-atomos", ofType: "mp4") else { return }
        
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.videoView.bounds
        playerLayer.videoGravity = .resizeAspectFill
        self.videoView.layer.addSublayer(playerLayer)
        
        player.play()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 11.5) {
            self.videoView.isHidden = true
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ViewController")
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}
