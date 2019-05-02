//
//  ModelController.swift
//  My CV
//
//  Created by Nick Nick  on 4/28/19.
//  Copyright © 2019 IndieApps. All rights reserved.
//

import UIKit

/*
 A controller object that manages a simple model -- a collection of month names.
 
 The controller serves as the data source for the page view controller; it therefore implements pageViewController:viewControllerBeforeViewController: and pageViewController:viewControllerAfterViewController:.
 It also implements a custom method, viewControllerAtIndex: which is useful in the implementation of the data source methods, and in the initial configuration of the application.
 
 There is no need to actually create view controllers for each page in advance -- indeed doing so incurs unnecessary overhead. Given the data model, these methods create, configure, and return a new view controller on demand.
 */


class CVModelController: NSObject, UIPageViewControllerDataSource {
    
    //var pageData: [[String:String]] = [[:]]
    var pageData = [CVPageModel]()
    
    override init() {
        super.init()
        pageData = getData()
    }
    
    func viewControllerAtIndex(_ index: Int, storyboard: UIStoryboard) -> CVDataViewController? {
        // Return the data view controller for the given index.
        if (self.pageData.count == 0) || (index >= self.pageData.count) {
            return nil
        }
        
        // Create a new view controller and pass suitable data.
        var id = ""
        switch pageData[index].contentType {
        case .plain: id = "CVPlainViewController"
            let cvPageController: CVPlainViewController  = storyboard.instantiateViewController(withIdentifier: id) as! CVPlainViewController
            cvPageController.pageData = pageData[index]
            cvPageController.setupWith(descpription: pageData[index].description, profileImageName: pageData[index].profileImageTitle)
            return cvPageController
        case .dynamic: id = "CVDynamicViewController"
            let cvPageController  = storyboard.instantiateViewController(withIdentifier: id) as! CVDynamicViewController
            cvPageController.pageData = pageData[index]
            cvPageController.setupWith(experienceData: pageData[index].experienceData)
            return cvPageController
        case .contact: id = "CVContactViewController"
             let cvPageController  = storyboard.instantiateViewController(withIdentifier: id) as! CVContactViewController
             cvPageController.pageData = pageData[index]
             cvPageController.setupWith(contactData: pageData[index].contactData)
             return cvPageController
        }
    }
    
    
    func indexOfViewController(_ viewController: CVDataViewController) -> Int {
        // Return the index of the given data view controller.
        // For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
        //let index = pageData[viewController.dataObject.pageIndex].pageIndex
        return viewController.index
    }
    
    // MARK: - Page View Controller Data Source
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController as! CVDataViewController)
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        
        index -= 1
        return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController as! CVDataViewController)
        if index == NSNotFound {
            return nil
        }
        
        index += 1
        if index == self.pageData.count {
            return nil
        }
        return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
    }
    
}

extension CVModelController {
    func getData()-> [CVPageModel] {
        let cvData: [CVPageModel] = [
            
            CVPageModel(pageIndex: 0,
                        title: "Hello",
                        description: "First Page",
                        profileImageTitle: "profile_image",
                        contentType: .plain,
                        experienceData: nil,
                        contactData: nil),
            CVPageModel(pageIndex: 1,
                        title: "A Little More",
                        description: "Second Page",
                        profileImageTitle: "profile_image", /* passing same imageto animate*/
                        contentType: .plain,
                        experienceData: nil,
                        contactData: nil),
            CVPageModel(pageIndex: 2,
                        title: "Experience",
                        description: nil,
                        profileImageTitle: nil,
                        contentType: .dynamic,
                        experienceData:
                                       [0:[
                                          CVExperienceModel(type: .job, imageName: "solargaps", description: "The SolarGaps mobile application lets you connect, control, and monitor your Smart Solar Blinds while at home and away. Download today to start generating your own energy.", url: URL(string: "https://itunes.apple.com/us/app/solargaps/id1391678834?mt=8")),
                                          CVExperienceModel(type: .job, imageName: "grilleye", description: "GrillEye® PRO+ (PRO Plus) is a  Grilling & Smoking Thermometer with patent pending Hybrid-Wireless and ADS Technology, that monitors your grill or smoker while you relax with your friends and family. As soon as food temperature reaches the desired levels GrillEye® sends a notification to your iOS device.", url: URL(string: "https://itunes.apple.com/us/app/grilleye-pro/id1301406737")),
                                          CVExperienceModel(type: .job, imageName: "qlyx", description: "This application is designed to work exclusively with the QLYX mount.", url: URL(string: "https://itunes.apple.com/US/app/id1180112661?mt=8"))
                                          ],
                                        1:[
                                          CVExperienceModel(type: .certificate, imageName: "webacademy", description: "Succesfully completed 'iOS Swift for begginers' course in January 2017", url: URL(string: "https://itunes.apple.com/us/app/solargaps/id1391678834?mt=8")),
                                          CVExperienceModel(type: .certificate, imageName: "ielts", description: "Succesfully passed IELTS test with band score of 7.5 in December 2018", url: URL(string: "https://itunes.apple.com/us/app/solargaps/id1391678834?mt=8")),
                                          ],
                                        2:[
                                            CVExperienceModel(type: .selfEducation, imageName: "harvard", description: "In process of finishing CS50 Harvard course. Going to take CS51 course to fully understand every detail about OOP and Stanford Swift course afterwards.", url: nil)
                                          ]
                                       ],
                        contactData: nil),
            CVPageModel(pageIndex: 3,
                        title: "A Little More",
                        description: "Second Page",
                        profileImageTitle: nil,
                        contentType: .contact,
                        experienceData: nil,
                        contactData: CVContactModel(phoneNumber: "+380636382093", email: "nick.softwaredev@gmail.com"))
        ]
        
        return cvData
    }
}
