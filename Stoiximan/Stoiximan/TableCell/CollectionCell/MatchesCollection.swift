//
//  MatchesCollection.swift
//  Stoiximan
//
//  Created by Rogério Fidelix on 09/10/2023.
//

import Foundation
import UIKit

class MatchesCollection: UICollectionViewCell {
    @IBOutlet var countdownLabel: UILabel!
    @IBOutlet var favouritesImageView: UIImageView!
    @IBOutlet var teamsLabel: UILabel!
    
    override func prepareForReuse() {
        countdownLabel.text = ""
        favouritesImageView.image = nil
        teamsLabel.text = ""
    }
    
    var eventDate: Date = Date()
    var timer: Timer!
    
    public func setupDate(receivadeDate: Date) {
        self.eventDate = receivadeDate
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(UpdateTime), userInfo: nil, repeats: true)
    }
    
    @objc func UpdateTime() {
        let userCalendar = Calendar.current
        let date = Date()
        let components = userCalendar.dateComponents([.hour, .minute, .month, .year, .day, .second], from: date)
        let currentDate = userCalendar.date(from: components)!
        
        let timeLeft = userCalendar.dateComponents([.day, .hour, .minute, .second], from: currentDate, to: eventDate)
        
        countdownLabel.text = "\(timeLeft.day!)d \(timeLeft.hour!)h \(timeLeft.minute!)m \(timeLeft.second!)s"
        
        endEvent(currentdate: currentDate, eventdate: eventDate)
    }
    
    func endEvent(currentdate: Date, eventdate: Date) {
        if currentdate >= eventdate {
            countdownLabel.text = "The event has gone"
            timer.invalidate()
        }
    }
}
