//
//  UserAnnotationView.swift
//  WhereBrianAtSwift
//
//  Created by Brian Donohue on 6/3/14.
//  Copyright (c) 2014 Brian Donohue. All rights reserved.
//

import Foundation
import MapKit

class UserAnnotationView: MKAnnotationView {
    let kContainerHeight: CGFloat = 54.0
    let kContainerWidth: CGFloat = 48.0
    let kPictureWidth: CGFloat = 40.0
    let kPictureHeight: CGFloat = 40.0
    
    init(annotation: MKAnnotation!, reuseIdentifier: String!) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        var container = UIImageView(image: UIImage(named: "dropperblue.png"))
        var userImage = UIImageView(frame: CGRectMake((kContainerWidth - kPictureWidth) / 2,
                                                      (kContainerHeight - kPictureHeight) / 2,
                                                      kPictureWidth, kPictureHeight))
        userImage.image = UIImage(named:"brian_profile.jpg")
        userImage.layer.cornerRadius = kPictureWidth / 2
        userImage.layer.masksToBounds = true
        self.addSubview(userImage)
        self.addSubview(container)
        
        self.frame = CGRect(x:0.0, y:0.0, width:kContainerWidth, height:kContainerHeight)
        self.centerOffset = CGPoint(x:0.0, y:kContainerHeight / 2)
    }
    
    init(frame: CGRect) {
        super.init(frame: frame)
    }
}
