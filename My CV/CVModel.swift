//
//  CVModel.swift
//  My CV
//
//  Created by Nick Nick  on 4/28/19.
//  Copyright © 2019 IndieApps. All rights reserved.
//

import Foundation


struct CVModel {
    
    enum ModelKeys: String {
        case titleKey = "titleKey"
        case descriptionKey = "descriptionKey"
        case imageKey = "imageKey"
        case buttonTitleKey = "buttonKey"
        case pageIndexKey = "pageIndexKey"
        case pageTypeKey = "pageTypeKey"
    }
    
    enum ContentType {
        case descriptive, intercative, contact
    }
    
    var title = ""
    var description = ""
    var imageTitle = ""
    var buttonTitle = ""
    var pageIndex = 0
    var contentType:  ContentType = .descriptive
    
}

extension CVModel {
    init(cvData: [String:String]){
        self.title = cvData[ModelKeys.titleKey.rawValue] ?? ""
        self.description = cvData[ModelKeys.descriptionKey.rawValue] ?? ""
        self.imageTitle = cvData[ModelKeys.imageKey.rawValue] ?? ""
        self.buttonTitle = cvData[ModelKeys.buttonTitleKey.rawValue] ?? ""
        self.pageIndex = Int(cvData[ModelKeys.pageIndexKey.rawValue] ?? "") ?? 0
        self.contentType = .contact
    }
}
