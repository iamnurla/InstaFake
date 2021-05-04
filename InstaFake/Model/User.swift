//
//  User.swift
//  InstaFake
//
//  Created by Yersultan Nalikhan on 12.04.2021.
//

import Foundation
import Firebase


struct User {
    let email: String
    let fullname: String
    let username: String
    let uid: String
    let profileImageUrl: String
    
    var isFollowed = false
    
    var isCurrentUser: Bool {return Auth.auth().currentUser?.uid == uid}
    
    init(dictionary: [String: Any]) {
        self.email = dictionary["email"] as? String ?? ""
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""

    }
    
}
