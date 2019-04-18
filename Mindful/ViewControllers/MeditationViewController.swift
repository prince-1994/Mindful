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


class MeditationViewController: UIViewController {
    enum AudioPlayerState{
        case paused
        case playing
        case completed
    }
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var audioCompletionSlider: UISlider!
    var audioPlayer = AVPlayer()
    var meditationType : MeditationType?
    var imageURL : URL?
    var audioURL : URL?
    var audioPlayerState : AudioPlayerState = .paused
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureViewController()
        configureAudioCompletionSlider()
        configurePlayPauseButton()
        updatePlayPauseButtonView()
    }
    
    func configurePlayPauseButton(){
        playPauseButton.addTarget(self, action: #selector(playPauseButtonTapped), for: .touchUpInside)
    }
    
    func configureViewController(){
        guard let meditationType = meditationType else {return}
        
        AppConstants.sharedInstance.getNameAndURLs(for: meditationType, handleName: { [weak self] (name, error) in
            if let name = name {
                self?.title = name
            }
        }) { [weak self] (imageURL, audioURL, error) in
            if let imageURL = imageURL {
                self?.imageURL = imageURL
                DispatchQueue.main.async {
                    self?.configureViews()
                }
            }
            if let audioURL = audioURL {
                self?.audioURL = audioURL
                DispatchQueue.main.async {
                    self?.configureAudioSession()
                }
            }
            
        }
    }
    
    func configureViews(){
        activityIndicator.startAnimating()
        SDWebImageDownloader.shared().downloadImage(with: imageURL, options: .continueInBackground, progress: nil) {[weak self] (image, data, error, isCompleted) in
            if (isCompleted && image != nil){
                self?.imageView.image = image!
            }else if error != nil {
                print(error!)
            }
            self?.activityIndicator.stopAnimating()
        }
    }
    
    func configureAudioSession(){
        // Removed deprecated use of AVAudioSessionDelegate protocol
        do  {
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)
            guard let audioURL = audioURL else {return}
            self.audioPlayer = AVPlayer(url: audioURL)
            self.audioPlayer.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 1), queue: DispatchQueue.main) {[weak self] (CMTime) -> Void in
                guard let self = self else {return}
                if self.audioPlayer.currentItem?.status == .readyToPlay{
                    let time = CMTime.seconds/self.audioPlayer.currentItem!.duration.seconds
                    self.audioCompletionSlider.value = Float(time)
                }
            }
            // add periodic time observer for player
        }catch {
            print("some Error occured")
        }
       
    }
    
    @objc func playPauseButtonTapped(){
        switch audioPlayerState {
        case .paused,.completed:
            audioPlayerState = .playing
        case .playing:
            audioPlayerState = .paused
        }
        updatePlayPauseButtonView()
    }
    
    func updatePlayPauseButtonView(){
        switch audioPlayerState {
        case .paused:
            playPauseButton.setTitle(String("\u{f28d}"), for: .normal)
            audioPlayer.pause()
        case .playing:
            playPauseButton.setTitle("\u{f0da}", for: .normal)
            audioPlayer.play()
        case .completed:
            playPauseButton.setTitle("\u{f021}", for: .normal)
        }
    }
    
    func configureAudioCompletionSlider(){
        self.audioCompletionSlider.value = Float(0)
        self.audioCompletionSlider.addTarget(self, action: #selector(audioCompletionSliderValueChanged), for: .valueChanged)
    }
    
    @objc func audioCompletionSliderValueChanged(){
        let value = Double(self.audioCompletionSlider.value) * self.audioPlayer.currentItem!.duration.seconds
        self.audioPlayer.seek(to: CMTime(seconds: value, preferredTimescale: 1))
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
