//
//  ViewController.swift
//  Mindful
//
//  Created by Yuvraj Sahu on 14/04/19.
//  Copyright © 2019 Yuvraj Sahu Apps. All rights reserved.
//

import UIKit

enum MeditationType : String{
    case focus = "Focus"
    case calmDown = "Calm Down"
    case destress = "Destress"
    case relax = "Relax"
}

class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    var excercises : [MeditationType] = [.focus,.calmDown,.destress,.relax]
    var colors : [UIColor] = [.green,.red,.yellow,.blue]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureCollectionView()
    }
    
    func configureCollectionView(){
        collectionView.dataSource = self
        collectionView.delegate = self
        let collectionViewLayout = UICollectionViewFlowLayout()
        let interItemSpacing = CGFloat(0.01)
        let minimumLineSpacing = CGFloat(0.01)
        collectionViewLayout.minimumInteritemSpacing = interItemSpacing
        collectionViewLayout.minimumLineSpacing = minimumLineSpacing
        let itemWidth = (collectionView.frame.width - interItemSpacing)/2.0
        let itemHeight = (collectionView.frame.height - minimumLineSpacing)/2.0
        collectionViewLayout.itemSize = CGSize(width: itemHeight, height: itemWidth)
    }
    
    // MARK:- collectionview datasource methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return excercises.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainVCCollectionViewCell", for: indexPath) as! MainVCCollectionViewCell
        cell.setValues(text: excercises[indexPath.row].rawValue, backgroundColor: colors[indexPath.row])
        return cell
    }
    
    // Mark:- collectionview Delegate methods
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MeditationViewController") as! MeditationViewController
        vc.meditationType = excercises[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

