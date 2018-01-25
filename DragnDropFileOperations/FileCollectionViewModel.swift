//
//  FileCollectionViewModel.swift
//  DragnDropFileOperations
//
//  Created by MAC01 on 24/01/18.
//  Copyright © 2018 Jayanta Gogoi. All rights reserved.
//

import UIKit

struct FileStruct{
    
    var fileName: UIImage?
    
}


class FileCollectionViewModel: NSObject {
    
    var fileCollection: [FileStruct] = []
    
    override init() {
        super.init()
    
        fileCollection.append(FileStruct(fileName: #imageLiteral(resourceName: "f1")))
        fileCollection.append(FileStruct(fileName: #imageLiteral(resourceName: "f2")))
        fileCollection.append(FileStruct(fileName: #imageLiteral(resourceName: "f3")))
        fileCollection.append(FileStruct(fileName: #imageLiteral(resourceName: "f4")))
        fileCollection.append(FileStruct(fileName: #imageLiteral(resourceName: "f5")))
 
    }
    
    
    
    
    
    
    
}





