//
//  FirstMyContentTableViewCell.swift
//  NewProduct
//
//  Created by 狍子 on 2021/6/23.
//

import UIKit
protocol FirstMyContentTableViewCellDelegate:NSObjectProtocol {
    func CellCollectionAction(cell:FirstMyContentTableViewCell,indexPath:NSIndexPath)

}
class FirstMyContentTableViewCell: UITableViewCell,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
    weak  var delegate : FirstMyContentTableViewCellDelegate?

    var dataArray = [String]()
    
    
    @IBOutlet weak var _collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let layout = UICollectionViewFlowLayout.init()
        layout.sectionInset = UIEdgeInsets(top: 0.0, left: 15, bottom: 0.0, right: 15)
        layout.itemSize = CGSize(width: (SCR_W-40)/2, height: (SCR_W-40)/2+5)
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.bounces = false;
        _collectionView.collectionViewLayout = layout;
//        _myCollectionView.register(UINib(nibName: firstCell, bundle: nil), forCellWithReuseIdentifier: firstCellID)
        _collectionView.register(UINib(nibName: "FirstMyContentCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FirstMyContentCollectionViewCellID")
//        _collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "reusableView")

        
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:FirstMyContentCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FirstMyContentCollectionViewCellID", for: indexPath) as! FirstMyContentCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
      return UIEdgeInsets(top: 0.0, left: 15, bottom: 0.0, right: 15)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.CellCollectionAction(cell: self, indexPath: indexPath as NSIndexPath)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
