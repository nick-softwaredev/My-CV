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
        self.contentType = getTypeFor(string: cvData[ModelKeys.pageTypeKey.rawValue] ?? "")
    }
    func getTypeFor(string value: String) -> ContentType {
        switch value {
          case "descriptive": return .descriptive
          case "interactive": return .intercative
          case "contact": return .contact
          default: return .descriptive
        }
    }
    
    //func retrieveExpirience() -> [] {}
    
}

struct ExperienceModel {
    
    enum ExperienceType {
        case job, certificate, selfEducation
    }
    
    let type: ExperienceType
    let image: String
    let description: String
    let url: String?
    
}
