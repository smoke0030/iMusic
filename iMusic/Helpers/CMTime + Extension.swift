//
//  CMTime + Extension.swift
//  iMusic
//
//  Created by Сергей on 18.07.2024.
//

import Foundation
import AVKit


extension CMTime {
    
    func displayTimeString() -> String {
        guard !CMTimeGetSeconds(self).isNaN else { return "" }
        let totalSeconds = Int(CMTimeGetSeconds(self))
        let seconds = totalSeconds % 60
        let minutes = totalSeconds / 60
        let timeFormattedString = String(format: "%02d:%02d", minutes, seconds)
        return timeFormattedString
    }
    
}
