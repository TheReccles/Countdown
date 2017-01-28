//
//  ItemCell.swift
//  Countdown
//
//  Created by Richard Eccles on 1/28/17.
//  Copyright © 2017 Richard Eccles. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var thumbImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var daysLeftLabel: UILabel!
    
    func configureCell(entry: Entry) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, yyyy"
        
        let calendar = NSCalendar.current
        
        let date1 = calendar.startOfDay(for: entry.created as! Date)
        let date2 = calendar.startOfDay(for: entry.dateEnd as! Date)
        
        let components = calendar.dateComponents([.day], from: date1, to: date2)
        
        titleLabel.text = entry.details
        dateLabel.text = formatter.string(from: entry.dateEnd as! Date)
        daysLeftLabel.text = "\(components.day!)"
        thumbImage.image = entry.toImage?.image as? UIImage
        
    }

}
