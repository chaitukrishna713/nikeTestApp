//
//  UIView+Extention.swift
//  nike coding test 2
//
//  Created by Chaitu Bk on 3/22/20.
//  Copyright © 2020 Chaitu Bk. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func pinTo(givenView: UIView) {
        translatesAutoresizingMaskIntoConstraints =  false
        topAnchor.constraint(equalTo: givenView.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: givenView.bottomAnchor).isActive = true
        leadingAnchor.constraint(equalTo: givenView.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: givenView.trailingAnchor).isActive = true
    }
}

