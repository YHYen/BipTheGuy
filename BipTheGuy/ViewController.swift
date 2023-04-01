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
    var imagePickerController = UIImagePickerController() // image picker controller factory
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        imagePickerController.delegate = self
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
    
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
    @IBAction func photoOrCameraPressed(_ sender: UIButton) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { (_) in
            self.accessPhotoLibrary()
            
        }
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (_) in
            self.accessCamera()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
            print("You click the cancel")
            
        }
        
        alertController.addAction(photoLibraryAction)
        alertController.addAction(cameraAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        bipTheImage()
    }
    
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            imageView.image = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = originalImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func accessPhotoLibrary() {
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func accessCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePickerController.sourceType = .camera
            present(imagePickerController, animated: true, completion: nil)
        } else {
            showAlert(title: "Camera Not Avaliable", message: "There is no camera avaliable on this device.")
        }
    }
}
