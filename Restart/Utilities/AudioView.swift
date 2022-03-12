//
//  AudioView.swift
//  Restart
//
//  Created by Anuj Soni on 12/03/22.
//
import Foundation
import AVFoundation
import SwiftUI

var player : AVAudioPlayer?


func playSound(sound : String, type:String) {

    if let url = Bundle.main.path(forResource: sound, ofType: type){
    do{
    player = try AVAudioPlayer(contentsOf:URL(fileURLWithPath:url))
    player?.play()
    }
    catch{
    print("Could Not Play the Sound")
    }
    }
}
