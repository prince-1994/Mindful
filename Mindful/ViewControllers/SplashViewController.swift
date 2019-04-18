//
//  SplashViewController.swift
//  Mindful
//
//  Created by Yuvraj Sahu on 14/04/19.
//  Copyright © 2019 Yuvraj Sahu Apps. All rights reserved.
//

import UIKit
import Lottie

class SplashViewController: UIViewController {
    @IBOutlet weak var reloadAnimationButton: UIButton!
    @IBOutlet weak var animationView: UIView!
    let splashAnimationView = AnimationView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        configureReloadAnimationButton()
        configureAnimationView()
        playSplashAnimation()
        
    }
    
    func configureReloadAnimationButton(){
        reloadAnimationButton.isHidden = true
//        reloadAnimationButton.addTarget(self, action: #selector(reloadAnimation), for: .touchUpInside)
    }
    
    @objc func reloadAnimation(){
        self.animationView.isHidden = false
        self.playSplashAnimation()
    }
    
    func navigateToMainVC(){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "MindfulNavigationController") as! UINavigationController
        UIApplication.shared.keyWindow?.rootViewController = vc
    }
    
    func playSplashAnimation(){
        splashAnimationView.play { [unowned self] (isCompleted) in
            if isCompleted {
                self.navigateToMainVC()
            }
        }
    }
    
    func configureAnimationView(){
        let splashAnimation = Animation.named("SplashAnimation")
        splashAnimationView.animation = splashAnimation
        splashAnimationView.frame = animationView.bounds
        animationView.addSubview(splashAnimationView)
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
