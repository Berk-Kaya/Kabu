//
//  TestCell.swift
//  Kabu
//
//  Created by Berk Kaya on 26.05.2018.
//  Copyright © 2018 Semih Delil. All rights reserved.
//

import UIKit

class TestCell: UICollectionViewCell  {

    @IBOutlet weak var bg: UIImageView!
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    var test = 0
    
    // img1 star for test 1
    
    
    var circlePositions: [CGRect] = [
        CGRect(x: 715, y: 90, width: 185, height: 180),
        CGRect(x: 715, y: 275, width: 185, height: 180),
        CGRect(x: 715, y: 460, width: 185, height: 180)
    ]
    
    var panGesture = UIPanGestureRecognizer()
    var panGesture2 = UIPanGestureRecognizer()
    var panGesture3 = UIPanGestureRecognizer()

    var result = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        img1.tag = 1
        img2.tag = 2
        img3.tag = 3
        
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(draggedView(_:)))
        panGesture2 = UIPanGestureRecognizer(target: self, action: #selector(draggedView2(_:)))
        panGesture3 = UIPanGestureRecognizer(target: self, action: #selector(draggedView3(_:)))
        
        img1.isUserInteractionEnabled = true
        img1.addGestureRecognizer(panGesture)

        img2.isUserInteractionEnabled = true
        img2.addGestureRecognizer(panGesture2)

        img3.isUserInteractionEnabled = true
        img3.addGestureRecognizer(panGesture3)

    }
    
    func setLayout(test: Int) {
        self.test = test
        
        if test == 0 {
            bg.image = #imageLiteral(resourceName: "18-Hikaye")
            img1.image = #imageLiteral(resourceName: "star-show")
            img2.image = #imageLiteral(resourceName: "empty")
            img3.image = #imageLiteral(resourceName: "empty")
        } else if test == 1 {
            bg.image = #imageLiteral(resourceName: "22-Hikaye")
            img1.image = #imageLiteral(resourceName: "cat-show")
            img2.image = #imageLiteral(resourceName: "cat-hide")
            img3.image = #imageLiteral(resourceName: "cat-show")
        } else if test == 2 {
            bg.image = #imageLiteral(resourceName: "26-Hikaye")
            img1.image = #imageLiteral(resourceName: "hearth-show")
            img2.image = #imageLiteral(resourceName: "hearth-hide")
            img3.image = #imageLiteral(resourceName: "hearth-hide")
        }
    }
    // star for test 1
    @objc func draggedView(_ sender:UIPanGestureRecognizer){
        let img = img1
        bringSubview(toFront: img!)
        let translation = sender.translation(in: self)
        img!.center = CGPoint(x: img!.center.x + translation.x, y: img!.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: self)
        
        if test == 0 {
            if circlePositions.contains(where: { (elem) -> Bool in
                return elem.contains(img!.center)
            }) {
                img?.isUserInteractionEnabled = false
                result = true
            }
        }
        
        sendResult()
    }

    
    @objc func draggedView2(_ sender:UIPanGestureRecognizer){
        let img = img2
        bringSubview(toFront: img!)
        let translation = sender.translation(in: self)
        img!.center = CGPoint(x: img!.center.x + translation.x, y: img!.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: self)
        sendResult()
    }

    
    @objc func draggedView3(_ sender:UIPanGestureRecognizer){
        let img = img3
        bringSubview(toFront: img!)
        let translation = sender.translation(in: self)
        img!.center = CGPoint(x: img!.center.x + translation.x, y: img!.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: self)
        sendResult()
    }

    private func sendResult() {
        if test == 0 {
            if circlePositions.contains(where: { (elem) -> Bool in
                return elem.contains(img2.center) || elem.contains(img3.center)
            }) {
                result = false
            } else if img1.isUserInteractionEnabled == false {
                result = true
            }
            KidsData.test1 = result ? "Test Doğru Yapıldı" : "Test Doğru Yapılmadı"
        } else if test == 1 {
            if circlePositions.contains(where: { (elem) -> Bool in
                return elem.contains(img1.center)
            }), circlePositions.contains(where: { (elem) -> Bool in
                return elem.contains(img3.center)
            }), !circlePositions.contains(where: { (elem) -> Bool in
                return elem.contains(img2.center)
            }) {
                result = true // POZİTİF
            } else {
                result = false
            }
            KidsData.test2 = result ? "Pozitif" : "Negatif"
        } else if test == 2 {
            if circlePositions.contains(where: { (elem) -> Bool in
                return elem.contains(img1.center)
            }), !circlePositions.contains(where: { (elem) -> Bool in
                return elem.contains(img3.center)
            }), !circlePositions.contains(where: { (elem) -> Bool in
                return elem.contains(img2.center)
            }) {
                result = true // POZİTİF
            } else {
                result = false
            }
            KidsData.test3 = result ? "Pozitif" : "Negatif"
        }
        
        print("TEST: ", result ? "Doğru " : "Yanlış")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        img1.isUserInteractionEnabled = true
        img1.frame.origin.x = 65
        img1.frame.origin.y = 228
        
        img2.isUserInteractionEnabled = true
        img2.frame.origin.x = 279
        img2.frame.origin.y = 244
        
        img3.isUserInteractionEnabled = true
        img3.frame.origin.x = 166
        img3.frame.origin.y = 442
    }
    
    
}
