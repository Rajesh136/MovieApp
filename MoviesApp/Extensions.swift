//
//  Extensions.swift
//  MovieApp
//
//  Created by techno krishna on 21/07/18.
//  Copyright © 2018 techno krishna. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView{
    func imageFromUrl(_ urlString:String) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            DispatchQueue.global(qos: .background).async {
                
                if let imgData = data{
                    DispatchQueue.main.async {
                        self.image = UIImage(data: imgData)
                    }
                }
            }
            }.resume()
    }
}

extension UILabel{
    func heightForView() -> CGFloat{
        let label:UILabel = UILabel(frame: CGRect(x:0, y:0, width:frame.width, height:CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        
        label.sizeToFit()
        return label.frame.height
    }
}

func min(mins:Int)->String {
    var hour = 0
    var mintes = mins
    while(mintes>60) {
        hour += 1
        mintes -= 60
    }
    return String(format: "\(hour)Hrs : \(mintes)Mins")
}
