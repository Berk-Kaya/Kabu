//
//  GameResultVC.swift
//  Kabu
//
//  Created by Berk Kaya on 26.05.2018.
//  Copyright © 2018 Semih Delil. All rights reserved.
//

import UIKit

class GameResultVC: UIViewController {

    @IBOutlet weak var kurum: UITextField!
    @IBOutlet weak var sehir: UITextField!
    @IBOutlet weak var isim: UITextField!
    @IBOutlet weak var dogumtarihi: UITextField!
    @IBOutlet weak var cinsiyet: UITextField!
    @IBOutlet weak var tarih: UITextField!

    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var result2Label: UILabel!
    @IBOutlet weak var result3Label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        kurum.text = KidsData.kurum
        sehir.text = KidsData.sehir
        isim.text = KidsData.isim
        dogumtarihi.text = KidsData.dt
        cinsiyet.text = KidsData.cinsiyet
        tarih.text = KidsData.tarih
        
        resultLabel.text = KidsData.test1
        result2Label.text = KidsData.test2
        result3Label.text = KidsData.test3
        
        resultLabel.backgroundColor = KidsData.test1 == "Test Doğru Yapıldı" ? greenColor : redColor
        result2Label.backgroundColor = KidsData.test2 == "Pozitif" ? greenColor : redColor
        result3Label.backgroundColor = KidsData.test3 == "Pozitif" ? greenColor : redColor

        
    }

    let redColor: UIColor = UIColor(red:0.77, green:0.25, blue:0.25, alpha:1.0)
    let greenColor = UIColor(red:0.17, green:0.88, blue:0.61, alpha:1.0)
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.

    }
    
    @IBAction func share(_ sender: Any) {
        
        DispatchQueue.main.async {
            let text = "This is the text....."
            let textShare = [ text ]
            let activityViewController = UIActivityViewController(activityItems: textShare , applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            self.present(activityViewController, animated: true, completion: nil)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
