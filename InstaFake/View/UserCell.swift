//
//  UserCell.swift
//  InstaFake
//
//  Created by Yersultan Nalikhan on 13.04.2021.
//

import UIKit

class UserCell: UITableViewCell {
    
    // MARK:    - PROPERTIES
    
    var viewModel : UserCellViewModel? {
        didSet {configure()}
    }
    
    private let profileImageView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        iv.image = #imageLiteral(resourceName: "photo-1486667970798-b29d1090ff95")
        return iv
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "iamnurla"
        return label
    }()
    
    private let fullnameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Nurlybek Amanzhol"
        return label
    }()
    
    
    
    // MARK:    - LIFECYCLE

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(profileImageView)
        profileImageView.setDimensions(height: 48, width: 48)
        profileImageView.layer.cornerRadius = 48 / 2
        profileImageView.centerY(inView: self, leftAnchor: leftAnchor,paddingLeft: 12)
        
        let stack = UIStackView(arrangedSubviews: [usernameLabel,fullnameLabel])
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .leading
        
        addSubview(stack)
        stack.centerY(inView: profileImageView, leftAnchor: profileImageView.rightAnchor,
                      paddingLeft:  8)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: HELPERS
    
    func configure() {
        guard let viewModel = viewModel else {return}
        
        profileImageView.sd_setImage(with: viewModel.profileImageUrl)
        usernameLabel.text = viewModel.username
        fullnameLabel.text = viewModel.fullname
    }
    
    
}
