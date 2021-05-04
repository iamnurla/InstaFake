//
//  CustomLoginSignButton.swift
//  InstaFake
//
//  Created by Yersultan Nalikhan on 10.04.2021.
//

import UIKit

class CustomLoginSignButton: UIButton {
    
    init(label: String) {
        super.init(frame: .zero)
        
        UIButton.init(type: .system)
        setTitle(label, for: .normal)
        setTitleColor(.white, for: .normal)
        backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        layer.cornerRadius = 5
        setHeight(50)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    

}
