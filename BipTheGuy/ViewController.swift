//
//  ViewController.swift
//  BipTheGuy
//
//  Created by 顏逸修 on 2023/4/1.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var audioPlayer: AVAudioPlayer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    func playSound(name: String) {
        // check to see if the sound data is exists and in the file
        if let sound = NSDataAsset(name: name) {
            // if sound data exists try to initial it and play the sound
            do {
                try audioPlayer = AVAudioPlayer(data: sound.data)
                audioPlayer.play()
            } catch {
                // if fail to initialize the sound print the error message
                print("😡 ERROR: \(error.localizedDescription). Could not initialize AVAudioPlayer object")
            }
        } else {
            // if fail to load the sound data from the file print the error message
            print("😡 ERROR: Could not read data from file \(name)")
        }
    }
    
    func bipTheImage() {
        let orginalImageFrame = imageView.frame
        let imageViewWidthShrink: CGFloat = 20
        let imageViewHeightShrink: CGFloat = 20
        
        let smallerImageViewFrame = CGRect(x: imageView.frame.origin.x + imageViewWidthShrink,
                                           y: imageView.frame.origin.y + imageViewHeightShrink,
                                           width: imageView.frame.width - (2 * imageViewWidthShrink),
                                           height: imageView.frame.height - (2 * imageViewHeightShrink))
        imageView.frame = smallerImageViewFrame
        playSound(name: "punchSound")
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10.0, options: []) {
            self.imageView.frame = orginalImageFrame
        }
    }
    

    @IBAction func punchButtonPressed(_ sender: UIButton) {
        bipTheImage()
    }
    
    
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        bipTheImage()
    }
    
}

