//
//  NewTestViewController
//  Kabu
//
//  Created by Berk Kaya on 14.05.2018.
//  Copyright © 2018 Semih Delil. All rights reserved.
//

import UIKit

class NewTestViewController: UIViewController {
    @IBOutlet weak var kurum: UITextField!
    @IBOutlet weak var sehir: UITextField!
    @IBOutlet weak var isim: UITextField!
    @IBOutlet weak var dogumtarihi: UITextField!
    @IBOutlet weak var cinsiyet: UITextField!
    @IBOutlet weak var tarih: UITextField!
    
    @IBAction func clicked(_ sender: Any) {
        guard
            let kurum = kurum.text,
            let sehir = sehir.text,
            let isim = isim.text,
            let dt = dogumtarihi.text,
            let cinsiyet = cinsiyet.text,
            let tarih = tarih.text else {
                return
        }
        
        KidsData.kurum = kurum
        KidsData.sehir = sehir
        KidsData.isim = isim
        KidsData.dt = dt
        KidsData.cinsiyet = cinsiyet
        KidsData.tarih = tarih
        
        
        if kurum == "" || sehir == "" || isim == "" || dt == "" || cinsiyet == "" || tarih == "" {
            let alert = UIAlertController(title: "Hata", message: "Lütfen eksik alanları doldurunuz", preferredStyle: .alert)
            let action = UIAlertAction(title: "Tamam", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true)
            return
        } else {
            self.performSegue(withIdentifier: "goToGame", sender: nil)
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NotificationCenter.default.addObserver(self, selector: #selector(NewTestViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(NewTestViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if self.view.frame.origin.y == 0{
            self.view.frame.origin.y -= 225
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0{
            self.view.frame.origin.y += 225
        }
    }



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

