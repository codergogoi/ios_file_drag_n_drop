//
//  GenericExtensions.swift
//  DragnDropFileOperations
//
//  Created by MAC01 on 24/01/18.
//  Copyright © 2018 Jayanta Gogoi. All rights reserved.
//

import Foundation
import UIKit


extension UIColor{
    
    func rgbColor(r: Double, g: Double, b: Double, a: Double)-> UIColor{
        
        return UIColor(red: CGFloat(r / 255), green:CGFloat(g/255), blue: CGFloat(b/255), alpha: CGFloat(a))
        
    }
    
    
}
