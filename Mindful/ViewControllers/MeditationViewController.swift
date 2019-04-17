//
//  MeditationViewController.swift
//  Mindful
//
//  Created by Yuvraj Sahu on 15/04/19.
//  Copyright © 2019 Yuvraj Sahu Apps. All rights reserved.
//

import UIKit
import AVFoundation
import SDWebImage
import FirebaseFirestore

class MeditationViewController: UIViewController,AVAudioPlayerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pauseAndPlayButton: UIButton!
    @IBOutlet weak var audioCompletionSlider: UISlider!
    var audioPlayer = AVAudioPlayer()
    var excerciseType : MeditationType?
    var imageURL : URL?
    var audioURL : URL?
    var colRef : CollectionReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureVariables()
        configureViews()
        playAudio()
        
    }
    
    func configureDocRef(){
        colRef = Firestore.firestore().collection("meditation")
    }
    
    func configureVariables(){
        guard let excerciseType = excerciseType else {return}
        imageURL = AppConstants.sharedInstance.getImageURL(for: excerciseType)
        audioURL = AppConstants.sharedInstance.getAudioURL(for: excerciseType)
    }
    
    func configureViews(){
        SDWebImageDownloader.shared().downloadImage(with: imageURL, options: .continueInBackground, progress: nil) {[weak self] (image, data, error, isCompleted) in
            if (isCompleted && image != nil){
                self?.imageView.image = image!
            }else if error != nil {
                print(error!)
            }
        }
    }
    
    func configureAudioSession(){
        // Removed deprecated use of AVAudioSessionDelegate protocol
        do  {
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)
        }catch {
            print("some Error occured")
        }
       
    }
    
    func playAudio(){
        guard let audioURL = audioURL else {return}
        guard let audioPlayer = try? AVAudioPlayer(contentsOf: audioURL) else {return} 
        audioPlayer.prepareToPlay()
        audioPlayer.play()
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
