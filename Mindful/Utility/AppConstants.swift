//
//  ImageDownloader.swift
//  Mindful
//
//  Created by Yuvraj Sahu on 16/04/19.
//  Copyright © 2019 Yuvraj Sahu Apps. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct AppConstantKeys {
    static var documentID = "random_document_id"
    static var name = "name"
    static var imageLink = "imageLink"
    static var musicLink = "link"
    static var doingRightNow = "doing_right_now"
    static var focus = "focus"
    static var calmDown = "calm_down"
    static var meditation = "meditation"
    static var destress = "destress"
    static var relax = "relax"
    static var session = "session"
}


class AppConstants{
    
    
    static var sharedInstance = AppConstants()
    private init(){}
    var colRef : CollectionReference! = Firestore.firestore().collection(AppConstantKeys.meditation)
    
    func getNameAndURLs(for type : MeditationType,handleName : @escaping (String?,Error?) -> Void, handleURLs :@escaping (URL?,URL?,Error?) -> Void ) {
        var name : String? = nil
        var imageURlString : String? = ""
        var musicURLString : String? = ""
        var docRef1 : DocumentReference! = nil
        switch type {
        case .focus:
            docRef1 = colRef.document(AppConstantKeys.focus)
        case .destress:
            docRef1 = colRef.document(AppConstantKeys.destress)
        case .calmDown:
            docRef1 = colRef.document(AppConstantKeys.calmDown)
        case .relax:
            docRef1 = colRef.document(AppConstantKeys.relax)
        }
        docRef1.getDocument { (docSnapshot, error) in
            guard error == nil else {
                handleName(nil,error)
                return
            }
            guard let docSnapshot = docSnapshot,docSnapshot.exists else {return}
            let myData = docSnapshot.data()
            name = myData?[AppConstantKeys.name] as? String
            handleName(name,nil)
        }
        
        let docRef2 = docRef1.collection(AppConstantKeys.session).document(AppConstantKeys.documentID)
        docRef2.getDocument { (docSnapshot, error) in
            guard error == nil else {
                handleURLs(nil,nil,error)
                return
            }
            guard let docSnapshot = docSnapshot,docSnapshot.exists else {return}
            let myData = docSnapshot.data()
            imageURlString = myData?[AppConstantKeys.imageLink] as? String
            musicURLString = myData?[AppConstantKeys.musicLink] as? String
            handleURLs(URL(string: imageURlString ?? ""),URL(string: musicURLString ?? ""),nil)
        }
    }
    
}
