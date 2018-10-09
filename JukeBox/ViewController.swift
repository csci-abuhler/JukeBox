//  ViewController.swift
//  JukeBox

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {
    var jukeBox: AVAudioPlayer?
    @IBOutlet var SongTitleLabel: UILabel!
    @IBOutlet var album: UIImageView!
    var collection = ["mzm.sjquuebr.aac.p", "narwhals", "wantyouback", "silence"]
   var titles = ["Bother by Stone Sour", "Narwhals by Mr Weebl", "Want U Back by Cher Lloyd", "Sound of Silence by Disturbed"]
    var covers = ["bother2", "narwhals2", "wantyouback2", "silence2"]
    var choice = 0
    var check = true
    
    @IBOutlet var volume: UISlider!
    
    @IBAction func volumeControl(_ sender: Any) {
        if jukeBox != nil {
            jukeBox?.volume = volume.value
        } // if
    } // volume
    
    override func viewDidLoad() {
        SongTitleLabel.text = titles[choice]
        album.image = UIImage(named: covers[choice])
        super.viewDidLoad()
    } // view did load

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    } // memory
    
    // press the play button to start a song
    // press the play button again to stop a song
    // to start another song, select the song then stop the current one then press play again
    func playMe(theSong: String) {
        let url = URL.init(fileURLWithPath: Bundle.main.path(forResource: theSong, ofType: "mp3")!)
        do {
            try jukeBox = AVAudioPlayer(contentsOf: url)
            jukeBox?.delegate = self
            jukeBox?.prepareToPlay()
        } catch let error as NSError {
            print("audioPlayer error \(error.localizedDescription)")
        } // do
        
        if let player = jukeBox {
            player.play()
        } // if
    } // play me
    
    // play or stop song
    @IBAction func play(_ sender: Any) {
        if check {
            playMe(theSong: collection[choice])
            check = false
        } else {
            if let player = jukeBox {
                player.stop()
            } // if
            check = true
        } // if
    } // play
    
    @IBAction func next(_ sender: Any) {
        choice += 1
        if choice == collection.count {
            choice = 0
        } // if
        SongTitleLabel.text = titles[choice]
        album.image = UIImage(named: covers[choice])
    } // next
    
    @IBAction func previous(_ sender: Any) {
        choice -= 1
        if choice < 0 {
            choice = collection.count - 1
        } // if
        SongTitleLabel.text = titles[choice]
        album.image = UIImage(named: covers[choice])
    } // previous
} // class
