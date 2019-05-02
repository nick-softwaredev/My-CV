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
    
    @IBOutlet weak var experienceCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = titleLabelText
        }
        // Do any additional setup after loading the view.
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

    }
    
    override func setupWith(descpription: String? = nil,profileImageName: String? = nil,experienceData: [Int: [CVExperienceModel]]? = nil ,contactData: CVContactModel? = nil) {
        experienceModel = experienceData ?? [Int : [CVExperienceModel]]()
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        let vc = segue.destination as? CVCollectionDetailViewController
        let index = sender as! IndexPath
        vc?.detailName = experienceModel[index.section]?[index.row].imageName ?? ""
        vc?.detailDescription = experienceModel[index.section]?[index.row].description ?? ""
        // Pass the selected object to the new view controller.
    }
 

}

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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CVCell", for: indexPath) as? CVCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setupCell(experienceModel[indexPath.section]?[indexPath.row].imageName ?? "")
        cell.imageTapped = { [weak self] in
            self?.performSegue(withIdentifier: "toDetailVC", sender: indexPath)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CVCollectionViewSectionHeader", for: indexPath) as? CVCollectionViewSectionHeader {
            let index = experienceModel.filter( {(element) in element.key == indexPath.section }).map { $0.key }.first ?? -1
            sectionHeader.setup(index)
            return sectionHeader
        }
        return UICollectionReusableView()
    }
    
}

extension CVDynamicViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //        let width = Int(collectionView.frame.width/2 - 2 - 2-2)
        //        return CGSize(width: width, height: width)
        let randomSize = 64 * Int(arc4random_uniform(UInt32(3))+1)
        return CGSize(width: randomSize, height: randomSize)
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


extension CVDynamicViewController:  UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
