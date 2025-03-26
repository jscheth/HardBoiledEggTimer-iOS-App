//
//  ViewController.swift
//  HardBoiled-EggTimer
//
//  Created by Jonathan Cheth on 3/26/25.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    let eggTimes = ["Soft": 3, "Medium": 4, "Hard": 7] //For testing purpose use the small seconds
    var timer = Timer()
    var player: AVAudioPlayer!
    var totalTime = 0
    var secondsPassed = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func hardnessPressed(_ sender: UIButton) {
        guard let hardness = sender.currentTitle, let time = eggTimes[hardness] else {
            print("Invalid button title or missing key in dictionary")
            return
        }
        
        totalTime = time
        print(totalTime)
        
        secondsPassed = 0
        progressView.progress = 0.0
        titleView.text = hardness
        
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target:self, selector: #selector(updateTimer), userInfo:nil, repeats: true)
        
    }
    
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            progressView.progress = Float(secondsPassed) / Float(totalTime)
            print(Float(secondsPassed) / Float(totalTime))
        } else {
            timer.invalidate()
            titleView.text = "DONE!"
            
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
        }
    }
    
    

}

