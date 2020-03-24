//
//  albumModel.swift
//  nike coding test 2
//
//  Created by Chaitu Bk on 3/22/20.
//  Copyright © 2020 Chaitu Bk. All rights reserved.
//

import Foundation

class albumModel: Decodable {
    var title: String?
    var id: String?
    var author: Author?
    var links: [Link]?
    var copyright: String?
    var country: String?
    var icon: String?
    var name: String?
    var updated: String?
    var results: [Result]?
}
