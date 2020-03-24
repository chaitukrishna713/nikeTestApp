//
//  albumCellModel.swift
//  nike coding test 2
//
//  Created by Chaitu Bk on 3/22/20.
//  Copyright © 2020 Chaitu Bk. All rights reserved.
//

import Foundation

struct TopHundredAlbumData {
    var albumFeed: albumModel?
    
    init(topHundredAlbumInfo: albumModel?) {
        guard let info = topHundredAlbumInfo else {return}
        self.albumFeed = info
    }
}
