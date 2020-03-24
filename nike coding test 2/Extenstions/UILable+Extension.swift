//
//  UILable+Extension.swift
//  nike coding test 2
//
//  Created by Chaitu Bk on 3/22/20.
//  Copyright © 2020 Chaitu Bk. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    func configure(withAdjustedWidth: Bool? = true) {
        numberOfLines = 0
        adjustsFontSizeToFitWidth = withAdjustedWidth ?? true
        translatesAutoresizingMaskIntoConstraints = false
    }
}
