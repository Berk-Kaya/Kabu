//
//  GameViewController.swift
//  Kabu
//
//  Created by Berk Kaya on 14.05.2018.
//  Copyright © 2018 Semih Delil. All rights reserved.
//

import UIKit
import AVFoundation

class GameViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var isVoiceOn = true
    var isMusicOn = true
    
    @IBOutlet weak var voiceButton: UIButton!
    @IBOutlet weak var musicButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    
    var page = 0
    lazy var limit = images.count - 1
    
    let player = AVQueuePlayer()
    let musicPlayer = AVQueuePlayer()

    var images: [UIImage] = [
        UIImage(named: "03-Hikaye")!,
        UIImage(named: "04-Hikaye")!,
        UIImage(named: "05-Hikaye")!,
        UIImage(named: "06-Hikaye")!,
        UIImage(named: "07-Hikaye")!,
        UIImage(named: "08-Hikaye")!,
        UIImage(named: "09-Hikaye")!,
        UIImage(named: "10-Hikaye")!,
        UIImage(named: "11-Hikaye")!,
        UIImage(named: "12-Hikaye")!,
        UIImage(named: "13-Hikaye")!,
        UIImage(named: "14-Hikaye")!,
        UIImage(named: "15-Hikaye")!,
        UIImage(named: "16-Hikaye")!,
        UIImage(named: "17-Hikaye")!,
        UIImage(named: "18-Hikaye")!,
        UIImage(named: "19-Hikaye")!,
        UIImage(named: "20-Hikaye")!,
        UIImage(named: "21-Hikaye")!,
        UIImage(named: "22-Hikaye")!,
        UIImage(named: "23-Hikaye")!,
        UIImage(named: "24-Hikaye")!,
        UIImage(named: "25-Hikaye")!,
        UIImage(named: "26-Hikaye")!,
        UIImage(named: "27-Hikaye")!,
        UIImage(named: "28-Hikaye")!,
        UIImage(named: "29-Hikaye")!,

    ]
    
    var names : [String?] = [ nil, "04-Hikaye", "05-Hikaye", "06-Hikaye", "07-Hikaye", "08-Hikaye", "09-Hikaye", "10-Hikaye", "11-Hikaye", "12-Hikaye", "13-Hikaye", "14-Hikaye", "15-Hikaye", "16-Hikaye", "17-Hikaye", nil, "19-Hikaye", "20-Hikaye", "21-Hikaye", "22-Hikaye", nil, "24-Hikaye", "25-Hikaye", nil, "27-Hikaye", "28-Hikaye", nil
    ]
    
    @IBOutlet weak var endGameButton: UIButton!
    var lastPlayed = ""
    var gesture: UITapGestureRecognizer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        collectionView.collectionViewLayout = layout
        collectionView.delegate = self
        collectionView.isScrollEnabled = false
        // Do any additional setup after loading the view.
        
        let nibName = UINib(nibName: "TestCell", bundle:nil)
        
        collectionView.register(nibName, forCellWithReuseIdentifier: "testCell")

        leftButton.isHidden = true
        
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self.musicPlayer.currentItem, queue: .main) { _ in
            self.lastPlayed = ""
            self.playMusic()
        }

        endGameButton.isHidden = true
        rightButton.isHidden = true
        
        gesture = UITapGestureRecognizer(target: self, action: #selector(goNext))
        gesture?.isEnabled = true
        view.addGestureRecognizer(gesture!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func endGame(_ sender: Any) {
        performSegue(withIdentifier: "gameResult", sender: nil)
    }
    @IBAction func voiceButtonClicked(_ sender: Any) {
        isVoiceOn = !isVoiceOn
        if !isVoiceOn {
            stopStory()
            voiceButton.setImage(UIImage(named: "voice-off"), for: .normal)
        } else {
            playStory()
            voiceButton.setImage(UIImage(named: "voice-on"), for: .normal)
        }
    }
    @IBAction func musicButtonClicked(_ sender: Any) {
        isMusicOn = !isMusicOn
        if !isMusicOn {
            stopMusic()
            musicButton.setImage(UIImage(named: "music-off"), for: .normal)
        } else {
            playMusic()
            musicButton.setImage(UIImage(named: "music-on"), for: .normal)
        }
    }
    
    @IBAction func leftClicked(_ sender: Any) {
        
        if page > 1 {
            page -= 1
            collectionView.scrollToItem(at: IndexPath(row: page, section: 0), at: .left, animated: true)
        }
        if page < 2 {
            leftButton.isHidden = true
        }
        if page < limit {
            rightButton.isHidden = false
        }
        
        player.removeAllItems()
        
        playStory()
        playMusic()

    }
    @IBAction func rightClicked(_ sender: Any? = nil) {
        if page < limit {
            page += 1
            collectionView.scrollToItem(at: IndexPath(row: page, section: 0), at: .right, animated: true)
        }
        if page == limit {
            rightButton.isHidden = true
        }
        if page > 1 {
            leftButton.isHidden = false
        }
        
        player.removeAllItems()
        
        playStory()
        playMusic()

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
    @objc func goNext() {
        rightClicked(nil)
        rightButton.isHidden = false
        view.removeGestureRecognizer(gesture!)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == limit {
            endGameButton.isHidden = false
        } else {
            endGameButton.isHidden = true
        }
        if indexPath.row == 15 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "testCell", for: indexPath) as! TestCell
            cell.setLayout(test: 0)
            player.removeAllItems()
            
            playStory()
            playMusic()
            
            return cell
            
            
        } else if indexPath.row == 19 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "testCell", for: indexPath) as! TestCell
            cell.setLayout(test: 1)
            player.removeAllItems()
            
            playStory()
            playMusic()
            
            return cell
            
            
        } else if indexPath.row == 23 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "testCell", for: indexPath) as! TestCell
            cell.setLayout(test: 2)
            player.removeAllItems()
            
            playStory()
            playMusic()
            
            return cell
            
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! imageCell
            cell.imageView.image = images[indexPath.row]
            
            
            player.removeAllItems()
            
            playStory()
            playMusic()
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print(CGSize(width: view.frame.width, height: view.frame.height))
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func playStory() {
        guard let songName = names[page],
        let url = Bundle.main.url(forResource: songName, withExtension: "m4a"),
        isVoiceOn
        else {
            player.removeAllItems()
            player.play()
            return
        }
        
        if player.items().count == 0 {
            player.removeAllItems()
            player.insert(AVPlayerItem(url: url), after: nil)
            player.play()
        } else {
            player.play()
        }
        
    }
    
    func stopStory() {
        player.pause()
    }
    
    
    func stopMusic() {
        lastPlayed = ""
        musicPlayer.removeAllItems()
        musicPlayer.play()
    }
    func playMusic() {
        guard isMusicOn else {
            musicPlayer.removeAllItems()
            musicPlayer.play()
            return
        }
        let songAttack = [7,8,9,19,20,23,24,27,28,29]
        let hurry = [10,11,12,13,14,15,16]
        let slow = [3,4,5,6,17,18,21,22,25,26]
        
        if songAttack.contains(page + 3) {
            if let url = Bundle.main.url(forResource: "Songattack", withExtension: "wav") {
                if lastPlayed != url.absoluteString {
                    musicPlayer.removeAllItems()
                    musicPlayer.insert(AVPlayerItem(url: url), after: nil)
                    musicPlayer.play()
                    lastPlayed = url.absoluteString
                }
            }
        } else if hurry.contains(page + 3) {
            if let url = Bundle.main.url(forResource: "Songhurry", withExtension: "wav") {
                if lastPlayed != url.absoluteString {
                    musicPlayer.removeAllItems()
                    musicPlayer.insert(AVPlayerItem(url: url), after: nil)
                    musicPlayer.play()
                    lastPlayed = url.absoluteString
                }
            }
        } else if slow.contains(page + 3) {
            if let url = Bundle.main.url(forResource: "Songslow-", withExtension: "wav") {
                if lastPlayed != url.absoluteString {
                    musicPlayer.removeAllItems()
                    musicPlayer.insert(AVPlayerItem(url: url), after: nil)
                    musicPlayer.play()
                    lastPlayed = url.absoluteString
                }
            }
        }
        
    }
    
    

}

