//
//  result.swift
//  nike coding test 2
//
//  Created by Chaitu Bk on 3/22/20.
//  Copyright © 2020 Chaitu Bk. All rights reserved.
//

import Foundation

class Result: Decodable {
    var artistName: String?
    var id: String?
    var releaseDate: String?
    var name: String?
    var kind: String?
    var copyright: String?
    var artistId: String?
    var contentAdvisoryRating: String?
    var artistUrl: String?
    var artworkUrl100: String?
    var genres: [Genre]?
    var url: String?
}
