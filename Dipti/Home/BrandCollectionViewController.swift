//
//  BrandCollectionViewController.swift
//  Dipti
//
//  Created by Hadi Sharghi on 1/22/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import UIKit


class BrandCollageCell: UICollectionViewCell {
    static let identifier = "brandCollageCell"
    
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var brandImageView: UIImageView!
    @IBOutlet weak var brandName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setup()
    }

    func setup() {
        infoView.layer.borderColor = UIColor.black.cgColor
        infoView.layer.borderWidth = 1
    }
}


class BrandConllectionViewController: UIViewController, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var collectionLayout: WLCollectionViewLayout = WLCollectionViewLayout()
    
    var brands = [
        "آدیداس",
        "خلیج",
        "دیپ تی",
        "فلان مارک",
        "بهمان"
        ] {
        didSet {
            collectionView?.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.decelerationRate = .fast
        let space: CGFloat                  = 20
        
        
        self.collectionView.collectionViewLayout = collectionLayout
        collectionView?.contentInset        = UIEdgeInsets(top: 0, left: space * 2, bottom: 0, right: space * 2)
        
        collectionLayout.scrollDirection    = .horizontal
        collectionView.isPagingEnabled = false
        
        let itemWidth                       = view.frame.width - space * 4 // w0 == ws
        collectionLayout.itemSize           = CGSize(width: itemWidth, height: 300)
        collectionLayout.minimumLineSpacing = space
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return brands.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BrandCollageCell.identifier, for: indexPath) as? BrandCollageCell {
            cell.brandName.text = brands[indexPath.item]
            return cell
        }
        
        fatalError()
    }
    
}




class WLCollectionViewLayout: UICollectionViewFlowLayout {
    
    var previousOffset: CGFloat    = 0
    var currentPage: Int           = 0
    
    override func prepare() {
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        guard let collectionView = self.collectionView else {
            return CGPoint.zero
        }
        
        guard let itemsCount = collectionView.dataSource?.collectionView(collectionView, numberOfItemsInSection: 0) else {
            return CGPoint.zero
        }
        
        if ((previousOffset > collectionView.contentOffset.x) && (velocity.x < 0)) {
            currentPage = max(currentPage - 1, 0)
        } else if ((previousOffset < collectionView.contentOffset.x) && (velocity.x > 0.0)) {
            currentPage = min(currentPage + 1, itemsCount - 1);
        }
        
        let itemEdgeOffset:CGFloat = (collectionView.frame.width - itemSize.width -  minimumLineSpacing * 2) / 2
        let updatedOffset: CGFloat = (itemSize.width + minimumLineSpacing) * CGFloat(currentPage) - (itemEdgeOffset + minimumLineSpacing);
        
        previousOffset = updatedOffset;
        
        return CGPoint(x: updatedOffset, y: proposedContentOffset.y);
    }
}
