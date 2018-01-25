//
//  ViewController.swift
//  DragnDropFileOperations
//
//  Created by MAC01 on 24/01/18.
//  Copyright © 2018 Jayanta Gogoi. All rights reserved.
//

import UIKit

class FileCollectionViewController: UICollectionViewController {

    var identifier = "fileCell"
    var model = FileCollectionViewModel()
    
    var recycleBinIcon: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Downloaded Files"
        collectionView?.backgroundColor = UIColor(white: 0.95, alpha: 1)
        collectionView?.register(FileCollectionViewCell.self, forCellWithReuseIdentifier: identifier)
 
        //collectionView?.alwaysBounceVertical = true
 
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 10
        collectionView?.collectionViewLayout = layout
 
        self.recycleBinIcon = UIImageView()
        self.recycleBinIcon.translatesAutoresizingMaskIntoConstraints = false
        recycleBinIcon.image = #imageLiteral(resourceName: "rb_empty")
        recycleBinIcon.contentMode = .scaleAspectFill
        self.view.addSubview(recycleBinIcon)
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[v0(100)]-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": recycleBinIcon]))
        
         self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0(100)]-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": recycleBinIcon]))
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return model.fileCollection.count
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! FileCollectionViewCell
        cell.delegate = self
        cell.fileIndex = indexPath.row
        let dataModel = self.model.fileCollection[indexPath.row]
        if let image = dataModel.fileName{
             cell.imgView?.image = image
        }
       
        cell.originPoint = cell.frame.origin
        return cell
    }
    
}

extension FileCollectionViewController : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 80, height: 100)
        
    }
    
 }

extension FileCollectionViewController : DragHandleDelegate{
    
    
    func updatePosition(sender: UIPanGestureRecognizer, origin: CGPoint?, itemIndex: Int) {
        
        let view = sender.view
        
        let translation = sender.translation(in: view)
        
        switch sender.state{
            
        case .began, .changed:
            view?.frame.origin = translation
        case .ended:
            DispatchQueue.main.async {
               
                if (view?.frame.intersects(self.recycleBinIcon.frame))!{
                    self.removeFileFromCollection(fileVew: view, origin: origin, isPutBack: false, index: itemIndex)
                }else{
                    self.removeFileFromCollection(fileVew: view, origin: origin, isPutBack: true, index: itemIndex)
                }
                
            }
          
        default:
            break;
            
        }
        
    }
    
    func removeFileFromCollection(fileVew: UIView?, origin: CGPoint?, isPutBack: Bool, index: Int){
        
        if isPutBack{
            
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 8, initialSpringVelocity: 8, options: .curveEaseInOut, animations: {
                if let originPoint = origin{
                    fileVew?.frame.origin = originPoint
                }
             }, completion: { (isDone) in
                self.recycleBinIcon.image = #imageLiteral(resourceName: "rb_empty")
            })
            
        }else{
            
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 8, initialSpringVelocity: 8, options: .curveEaseInOut, animations: {
               
                fileVew?.alpha = 0
                self.recycleBinIcon.image = #imageLiteral(resourceName: "rb_full")
                self.model.fileCollection.remove(at: index)
                self.collectionView?.reloadData()
            }, completion: { (isDone) in
                self.recycleBinIcon.image = #imageLiteral(resourceName: "rb_empty")
            })
           
        }
 
    }
 
}

 









