//
//  FileCollectionViewCell.swift
//  DragnDropFileOperations
//
//  Created by MAC01 on 24/01/18.
//  Copyright © 2018 Jayanta Gogoi. All rights reserved.
//

import UIKit

protocol DragHandleDelegate {
    
    func updatePosition(sender: UIPanGestureRecognizer, origin: CGPoint?, itemIndex: Int)
    
}


class FileCollectionViewCell: UICollectionViewCell {
    
    var delegate: DragHandleDelegate?
    var originPoint: CGPoint?
    var fileIndex: Int = 0
    
    var imgView : UIImageView? = {
       
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.backgroundColor = UIColor.clear
        
        return imgView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(updatePositionInDelegate(sender:)))
        self.addGestureRecognizer(panGesture)
        
    }
    
    @objc func updatePositionInDelegate(sender: UIPanGestureRecognizer){
        
        self.delegate?.updatePosition(sender: sender, origin: originPoint,itemIndex: fileIndex)
    }
 
    
    func setupView(){
        
        self.addSubview(imgView!)
        self.bringSubview(toFront: imgView!)
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-5-[v0]-5-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": imgView!]))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-5-[v0]-5-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": imgView!]))
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    
    
    
}
