//
//  CVPageModel.swift
//  My CV
//
//  Created by Nick Nick  on 4/30/19.
//  Copyright © 2019 IndieApps. All rights reserved.
//

import Foundation

enum CVPageModelKeys: String {
    case titleKey = "titleKey"
    case descriptionKey = "descriptionKey"
    case profileImageKey = "profileImageKey"
    case contentTypeKey = "contentTypeKey"
    case experienceData = "experienceDataKey"
    case contactData = "contactDataKey"
}

struct CVPageModel {
    
//    enum ModelKeys: String {
//        case titleKey = "titleKey"
//        case descriptionKey = "descriptionKey"
//        case profileImageKey = "profileImageKey"
//        case contentTypeKey = "contentTypeKey"
//    }
    
    enum ContentType {
        case plain, dynamic, contact
    }
    
    var title = ""
    var description = ""
    var profileImageTitle = ""
    var contentType:  ContentType = .plain
    var experienceData: [CVExperienceModel]?
    var contactData: CVContactModel?
    
}

extension CVPageModel {
    init(cvData: [String: AnyObject]){
        self.title = cvData[CVPageModelKeys.titleKey.rawValue] as? String ?? ""
        self.description = cvData[CVPageModelKeys.descriptionKey.rawValue] as? String ?? ""
        self.profileImageTitle = cvData[CVPageModelKeys.profileImageKey.rawValue] as? String ?? ""
        self.contentType = cvData[CVPageModelKeys.contentTypeKey.rawValue] as? ContentType ?? .plain
        self.experienceData = cvData[CVPageModelKeys.experienceData.rawValue] as? [CVExperienceModel] ?? [CVExperienceModel]()
        self.contactData = cvData[CVPageModelKeys.contactData.rawValue] as? CVContactModel ?? CVContactModel()
    }
}
