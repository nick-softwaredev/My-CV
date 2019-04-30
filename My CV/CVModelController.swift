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
    var pageData = [CVModel]()
    
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
        let cvDataViewController = storyboard.instantiateViewController(withIdentifier: "CVDataViewController") as! CVDataViewController
        cvDataViewController.dataObject = pageData[index]
        cvDataViewController.index = index
        if pageData[index].contentType == .intercative {
            cvDataViewController.experienceObject = getExperience()
        }
        return cvDataViewController
    }
    
    
    func indexOfViewController(_ viewController: CVDataViewController) -> Int {
        // Return the index of the given data view controller.
        // For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
        //let index = pageData[viewController.dataObject.pageIndex].pageIndex
        let index = viewController.index
        return index
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
    func getData()-> [CVModel] {
        let inputData = [["titleKey": "Hello!", "descriptionKey" : "This is cv text for this topic", "imageKey": "backround", "buttonTitleKey": "MyButton", "pageIndexKey" : "34", "pageTypeKey" : "descriptive"],["titleKey": "next!", "descriptionKey" : "This is cv text for this topic", "imageKey": "giphy.gif", "buttonTitleKey": "MyButton", "pageIndexKey" : "1", "pageTypeKey" : "descriptive"], ["titleKey": "Buy!", "descriptionKey" : "This is cv text for this topic", "imageKey": "image.jpg", "buttonTitleKey": "MyButton", "pageIndexKey" : "2", "pageTypeKey" : "interactive"], ["titleKey": "Buy!", "descriptionKey" : "This is cv text for this topic", "imageKey": "image.jpg", "buttonTitleKey": "MyButton", "pageIndexKey" : "3", "pageTypeKey" : "contact"]]
        var cvData = [CVModel]()
        inputData.forEach { (modelDictionary) in
            cvData.append(CVModel(cvData: modelDictionary))
        }
        return cvData
    }
    func getExperience()-> [Int: [ExperienceModel]]{
        let data = [0: [ExperienceModel(type: .job, image: "example", description: "This is the example project", url: "example.url")]]
        return data
    }
}
