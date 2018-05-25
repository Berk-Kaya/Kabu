//
//  GameViewController.swift
//  Kabu
//
//  Created by Berk Kaya on 14.05.2018.
//  Copyright © 2018 Semih Delil. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    var images: [UIImage] = [
        UIImage(named: "003-hikaye")!,
        UIImage(named: "004-hikaye")!,
        UIImage(named: "005-hikaye")!,
        UIImage(named: "006-hikaye")!,
        UIImage(named: "007-hikaye")!,
        UIImage(named: "008-hikaye")!,
        UIImage(named: "009-hikaye")!,
        UIImage(named: "010-hikaye")!,
        UIImage(named: "011-hikaye")!,
        UIImage(named: "012-hikaye")!,
        UIImage(named: "013-hikaye")!,
        UIImage(named: "014-hikaye")!,
        UIImage(named: "015-hikaye")!,
        UIImage(named: "016-hikaye")!,
        UIImage(named: "017-hikaye")!,
        UIImage(named: "018-hikaye")!,
        UIImage(named: "019-hikaye")!,
        UIImage(named: "020-hikaye")!,
        UIImage(named: "021-hikaye")!,
        UIImage(named: "021-hikaye")!,
        UIImage(named: "023-hikaye")!,
        UIImage(named: "024-hikaye")!,
        UIImage(named: "025-hikaye")!,
        UIImage(named: "026-hikaye")!,
        UIImage(named: "027-hikaye")!,
        UIImage(named: "028-hikaye")!,
        UIImage(named: "029-hikaye")!,


    ]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
   
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! imageCell
        cell.imageView.image = images[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
        
    }

}

