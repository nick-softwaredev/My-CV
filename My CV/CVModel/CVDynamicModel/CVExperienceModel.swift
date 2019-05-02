//
//  CVExperienceModel.swift
//  My CV
//
//  Created by Nick Nick  on 4/30/19.
//  Copyright © 2019 IndieApps. All rights reserved.
//

import Foundation

struct CVExperienceModel {
    
    enum ExperienceType {
        case job, certificate, selfEducation
    }
    
    let type: ExperienceType
    let imageName: String
    let description: String
    let url: URL?
}
