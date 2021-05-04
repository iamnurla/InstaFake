//
//  ProfileHeaderViewModel.swift
//  InstaFake
//
//  Created by Yersultan Nalikhan on 12.04.2021.
//

import UIKit

struct ProfileHeaderViewModel {
    let user: User
    
    var profileImageUrl: URL? {
        return URL(string: user.profileImageUrl)
    }
    
    var fullname: String {
        return user.fullname
    }
    
    var followButtonText: String {
        if user.isCurrentUser {
            return "Edit Profile"
        }
        
        return user.isFollowed ? "Following" : "Follow"
        
    }
    
    var followButtonBackgroundColor: UIColor {
        return user.isCurrentUser ? .white : .systemBlue
    }
    
    var followButtonTextColor: UIColor {
        return user.isCurrentUser ? .black : .white
    }
    
    init(user: User) {
        self.user = user
    }
    

    
}
