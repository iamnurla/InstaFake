//
//  ProfileCell.swift
//  InstaFake
//
//  Created by Yersultan Nalikhan on 12.04.2021.
//

import UIKit

class ProfileCell: UICollectionViewCell {
    
    // MARK:    -PROPERTIES
    
    private let postImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "photo_2021-02-03 20.57.53")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    // MARK:    -LIFECYCLE
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(postImageView)
        postImageView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
