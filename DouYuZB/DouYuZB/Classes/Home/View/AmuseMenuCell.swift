//
//  AmuseMenuCell.swift
//  DouYuZB
//
//  Created by new on 2017/5/16.
//  Copyright © 2017年 9-kylins. All rights reserved.
//

import UIKit

private let kMenuCellID = "kMenuCellID"
class AmuseMenuCell: UICollectionViewCell {

    //MARK:- 定义属性
    var groupModels : [AnchorGroupModel]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    //MARK:- 控件属性
    @IBOutlet var collectionView: UICollectionView!
    
    //MARK:- 从xib中加载出来
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(UINib(nibName: "GameCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: kMenuCellID)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let itemW = collectionView.bounds.width / 4
        let itemH = collectionView.bounds.height / 2
        layout.itemSize = CGSize(width: itemW, height: itemH)
    }
}

extension AmuseMenuCell : UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groupModels?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kMenuCellID, for: indexPath) as! GameCollectionViewCell
        cell.baseModel = groupModels![indexPath.item]
        cell.clipsToBounds = true
        return cell
    }
}




