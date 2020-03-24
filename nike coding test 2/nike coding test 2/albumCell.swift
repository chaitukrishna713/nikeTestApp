//
//  albumCell.swift
//  nike coding test 2
//
//  Created by Chaitu Bk on 3/22/20.
//  Copyright © 2020 Chaitu Bk. All rights reserved.
//

import UIKit

class albumCell: UITableViewCell {
    var albumArt: UIImageView = UIImageView()
    var artistNameLable = UILabel()
    var albumNameLable = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(albumArt)
        addSubview(artistNameLable)
        addSubview(albumNameLable)
        autoLayoutAlbumArt()
        autoLayoutAlbumInfo()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func populateCellWith(artist: String?, album: String?, artWork: String) {
        self.albumNameLable.text = album ?? ""
        self.artistNameLable.text = artist ?? ""
        self.albumArt.downloaded(from: artWork)
    }
    
    private func autoLayoutAlbumArt() {
        albumArt.translatesAutoresizingMaskIntoConstraints = false
        albumArt.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        albumArt.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        albumArt.heightAnchor.constraint(equalToConstant: 100).isActive = true
        albumArt.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    private func autoLayoutAlbumInfo() {
        // album name layout
        albumNameLable.configure()
        albumNameLable.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        albumNameLable.leadingAnchor.constraint(equalTo: albumArt.trailingAnchor, constant: 16).isActive = true
        albumNameLable.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        
        albumNameLable.heightAnchor.constraint(equalToConstant: 50).isActive = true
        albumNameLable.font = .boldSystemFont(ofSize: 20)
        
        // artist name layout
        artistNameLable.configure()
        artistNameLable.heightAnchor.constraint(equalToConstant: 50).isActive = true
        artistNameLable.topAnchor.constraint(equalTo: albumNameLable.bottomAnchor, constant: 2).isActive = true
        artistNameLable.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        artistNameLable.leadingAnchor.constraint(equalTo: albumArt.trailingAnchor, constant: 16).isActive = true
        artistNameLable.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        artistNameLable.font = .systemFont(ofSize: 16)
    }
}
