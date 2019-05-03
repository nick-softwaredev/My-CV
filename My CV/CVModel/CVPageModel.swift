//
//  CVPageModel.swift
//  My CV
//
//  Created by Nick Nick  on 4/30/19.
//  Copyright © 2019 IndieApps. All rights reserved.
//

import Foundation

enum CVPageModelKeys: String {
    case pageIndexKey = "pageIndexKey"
    case titleKey = "titleKey"
    case descriptionKey = "descriptionKey"
    case profileImageKey = "profileImageKey"
    case contentTypeKey = "contentTypeKey"
    case experienceData = "experienceDataKey"
    case contactData = "contactDataKey"
}

//Defines model of the entity(page)
struct CVPageModel {
    enum ContentType {
        case plain, dynamic, contact
    }

    var pageIndex = 0
    var title = ""
    var description: String?
    var profileImageTitle: String?
    var contentType:  ContentType = .plain
    var experienceData: [Int: [CVExperienceModel]]?
    var contactData: CVContactModel?
    
}

extension CVPageModel {
    init(cvData: [String: AnyObject]){
        self.pageIndex = cvData[CVPageModelKeys.pageIndexKey.rawValue] as? Int ?? 0
        self.title = cvData[CVPageModelKeys.titleKey.rawValue] as? String ?? ""
        self.description = cvData[CVPageModelKeys.descriptionKey.rawValue] as? String ?? ""
        self.profileImageTitle = cvData[CVPageModelKeys.profileImageKey.rawValue] as? String ?? ""
        self.contentType = cvData[CVPageModelKeys.contentTypeKey.rawValue] as? ContentType ?? .plain
        self.experienceData = cvData[CVPageModelKeys.experienceData.rawValue] as? [Int: [CVExperienceModel]] ?? [Int: [CVExperienceModel]]()
        self.contactData = cvData[CVPageModelKeys.contactData.rawValue] as? CVContactModel ?? CVContactModel()
    }
}
