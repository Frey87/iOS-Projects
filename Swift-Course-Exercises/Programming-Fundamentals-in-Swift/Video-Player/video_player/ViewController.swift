//
//  ViewController.swift
//  video_player
//
//  Created by Valentyn Verovkin on 26.03.2026.
//

import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
                playVideo()
        }
    
    private func playVideo(){
        guard let path=Bundle.main.path(forResource: "Aircraft modeling", ofType:"mp4") else {
                    debugPrint("Aircraft modeling.mp4 not found")
                    return
                }
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerController = AVPlayerViewController()
        playerController.player=player
        present(playerController, animated: true) {
        player.play()
        }
    }


}

