//
//  CVInteractiveView.swift
//  My CV
//
//  Created by Nick Nick  on 4/28/19.
//  Copyright © 2019 IndieApps. All rights reserved.
//

import UIKit

class CVInteractiveView: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var portfolioCollectionView: UICollectionView!
    
    var experinceData = [Int: [ExperienceModel]]()
    
    func setup(with data: [Int: [ExperienceModel]]) {
        experinceData = data
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func layoutSubviews() {
        portfolioCollectionView.delegate = self
        portfolioCollectionView.dataSource = self
        portfolioCollectionView.register(CVCollectionViewCell.self, forCellWithReuseIdentifier: "CVCell")
        portfolioCollectionView.register(CVCollectionViewSectionHeader.self, forSupplementaryViewOfKind: "UICollectionElementKindSectionHeader", withReuseIdentifier: "CVCollectionViewSectionHeader")
    }
    
    func refreshCollectionView() {
        DispatchQueue.main.async {
            self.portfolioCollectionView.reloadData()
        }
    }

}

extension CVInteractiveView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return experinceData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return experinceData[section]?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CVCell", for: indexPath)
       // cell.setup(experinceData[indexPath.section][indexPath])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CVCollectionViewSectionHeader", for: indexPath) as? CVCollectionViewSectionHeader {
            let index = experinceData.filter( {(element) in element.key == indexPath.section }).map { $0.0 }.first
            switch index {
            case 0:  //sectionHeader.sectionHeaderlabel.text = "Job Experience"
                sectionHeader.backgroundColor = .blue
            case 1: //sectionHeader.sectionHeaderlabel.text = "Certificates"
                sectionHeader.backgroundColor = .blue
            case 2: sectionHeader.sectionHeaderlabel.text = ""
            default: //sectionHeader.sectionHeaderlabel.text = "Section Name"
                sectionHeader.backgroundColor = .blue
            }
            return sectionHeader
        }
        return UICollectionReusableView()
    }
    
}

extension CVInteractiveView: UICollectionViewDelegateFlowLayout {
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
