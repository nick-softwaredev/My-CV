//
//  CVDynamicViewController.swift
//  My CV
//
//  Created by Nick Nick  on 5/1/19.
//  Copyright © 2019 IndieApps. All rights reserved.
//

import UIKit

class CVDynamicViewController: CVDataViewController, CVSetupDelegate {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    private var experienceModel = [Int: [CVExperienceModel]]()
    private let cellID = "CVCell"
    private let detailSegueID = "toDetailVC"
    private let headerID = "CVCollectionViewSectionHeader"
    
    @IBOutlet weak var experienceCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = titleLabelText
    }
 
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

    }
    
    override func setupWith(description: String? = nil,profileImageName: String? = nil,experienceData: [Int: [CVExperienceModel]]? = nil ,contactData: CVContactModel? = nil) {
        experienceModel = experienceData ?? [Int : [CVExperienceModel]]()
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        guard let index = sender as? IndexPath else {
            return
        }
        let vc = segue.destination as? CVCollectionDetailViewController
        vc?.detailName = experienceModel[index.section]?[index.row].name ?? ""
        vc?.detailDescription = experienceModel[index.section]?[index.row].description ?? ""
        vc?.backgroundImage = currentBackgroundImage
        vc?.link = experienceModel[index.section]?[index.row].url
    }
 

}

// Mark: - CollectionView Delegate and Data Source

extension CVDynamicViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return experienceModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return experienceModel[section]?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        return
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? CVCollectionViewCell else {
            return CVCollectionViewCell()
        }
        cell.setupCell(experienceModel[indexPath.section]?[indexPath.row].imageName ?? "")
        cell.imageTapped = { [weak self] in
            self?.performSegue(withIdentifier: self?.detailSegueID ?? "", sender: indexPath)
        }
        UIView.animate(withDuration: 1, delay: 1 * Double(indexPath.row), usingSpringWithDamping: 1, initialSpringVelocity: 1, options: indexPath.row % 2 == 0 ? .transitionFlipFromLeft : .transitionFlipFromRight, animations: {
            if indexPath.row % 2 == 0 {
                self.viewSlideInFromLeft(toRight: cell)
            }
            else {
                self.viewSlideInFromRight(toLeft: cell)
            }
        })
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerID, for: indexPath) as? CVCollectionViewSectionHeader {
            //section number is equal to experienceData key, so we retrieve key's value (Int)
            let index = experienceModel.filter( {(element) in element.key == indexPath.section }).map { $0.key }.first ?? -1
            sectionHeader.setupTitle(section: index)
            return sectionHeader
        }
        return UICollectionReusableView()
    }
    
}

// Mark: - Custom CollectionView layout setup

extension CVDynamicViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //let randomSize = 64 * Int(arc4random_uniform(UInt32(3))+1)
        return CGSize(width: collectionView.frame.width/2-4, height: collectionView.frame.width/2-4)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return (UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
}

//Mark: - Animation Methods
private var kSlideAnimationDuration: CFTimeInterval {
    get {
    return 0.4
    }
}

extension CVDynamicViewController: CAAnimationDelegate {
     func viewSlideInFromRight(toLeft views: UIView) {
        var transition: CATransition? = nil
        transition = CATransition.init()
        transition?.duration = kSlideAnimationDuration
        transition?.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition?.type = CATransitionType.push
        transition?.subtype = CATransitionSubtype.fromRight
        views.layer.add(transition!, forKey: nil)
    }
    
     func viewSlideInFromLeft(toRight views: UIView) {
        var transition: CATransition? = nil
        transition = CATransition.init()
        transition?.duration = kSlideAnimationDuration
        transition?.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition?.type = CATransitionType.push
        transition?.subtype = CATransitionSubtype.fromLeft
        views.layer.add(transition!, forKey: nil)
    }
    
     func viewSlideInFromTop(toBottom views: UIView) {
        var transition: CATransition? = nil
        transition = CATransition.init()
        transition?.duration = kSlideAnimationDuration
        transition?.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition?.type = CATransitionType.push
        transition?.subtype = CATransitionSubtype.fromBottom
        views.layer.add(transition!, forKey: nil)
    }
    
     func viewSlideInFromBottom(toTop views: UIView) {
        var transition: CATransition? = nil
        transition = CATransition.init()
        transition?.duration = kSlideAnimationDuration
        transition?.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition?.type = CATransitionType.push
        transition?.subtype = CATransitionSubtype.fromTop
        views.layer.add(transition!, forKey: nil)
    }
}
