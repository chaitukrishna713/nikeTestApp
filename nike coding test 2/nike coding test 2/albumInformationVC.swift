//
//  albumInformationVC.swift
//  nike coding test 2
//
//  Created by Chaitu Bk on 3/23/20.
//  Copyright © 2020 Chaitu Bk. All rights reserved.
//

import UIKit
import SafariServices

class albumInformationVC: UIViewController {
    
    var scrollView: UIScrollView = UIScrollView()
    var containerVIew: UIView = UIView()
    var albumArt: UIImageView = UIImageView()
    var albumInfo: UILabel = UILabel()
    var findAlbumButton: UIButton = UIButton()
    var albumResult: Result = Result()
    
    init(albumResult: Result) {
        super.init(nibName: nil, bundle: nil)
        self.albumResult = albumResult
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        title = albumResult.artistName
        scrollView.addSubview(containerVIew)
        containerVIew.addSubview(albumArt)
        containerVIew.addSubview(albumInfo)
        containerVIew.addSubview(findAlbumButton)
        view.backgroundColor = .white
        autoLayoutScrollView()
        autoLayoutAlbumArt()
        autoLayoutInfoAndButton()
    }
    
    func autoLayoutScrollView() {
        scrollView.pinTo(givenView: view)
        containerVIew.pinTo(givenView: scrollView)
        let heightAnchor = containerVIew.heightAnchor.constraint(equalTo: view.heightAnchor)
        heightAnchor.priority = UILayoutPriority(rawValue: 250)
        heightAnchor.isActive = true
        containerVIew.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    
    func autoLayoutAlbumArt() {
        albumArt.translatesAutoresizingMaskIntoConstraints = false
        albumArt.topAnchor.constraint(equalTo: containerVIew.topAnchor, constant: 20).isActive = true
        albumArt.centerXAnchor.constraint(equalTo: containerVIew.centerXAnchor).isActive = true
        albumArt.heightAnchor.constraint(equalToConstant: 300).isActive = true
        albumArt.widthAnchor.constraint(equalToConstant: 300).isActive = true
        albumArt.layer.cornerRadius = 5
        albumArt.clipsToBounds = true
        albumArt.downloaded(from: self.albumResult.artworkUrl100 ?? "")
    }
    
    func autoLayoutInfoAndButton() {
        // layout info
        albumInfo.configure(withAdjustedWidth: false)
        albumInfo.textAlignment = .left
        albumInfo.topAnchor.constraint(equalTo: albumArt.bottomAnchor, constant: 20).isActive = true
        albumInfo.leadingAnchor.constraint(equalTo: containerVIew.leadingAnchor, constant: 20).isActive = true
        albumInfo.trailingAnchor.constraint(equalTo: containerVIew.trailingAnchor, constant: -20).isActive = true
        
        // layout button
        findAlbumButton.translatesAutoresizingMaskIntoConstraints = false
        findAlbumButton.topAnchor.constraint(equalTo: albumInfo.bottomAnchor, constant: 20).isActive = true
        findAlbumButton.leadingAnchor.constraint(equalTo: containerVIew.leadingAnchor, constant: 20).isActive = true
        findAlbumButton.bottomAnchor.constraint(greaterThanOrEqualTo: containerVIew.bottomAnchor, constant: -20).isActive = true
        findAlbumButton.trailingAnchor.constraint(equalTo: containerVIew.trailingAnchor, constant: -20).isActive = true
        findAlbumButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        findAlbumButton.centerXAnchor.constraint(equalTo: containerVIew.centerXAnchor).isActive = true
        findAlbumButton.layer.cornerRadius = 5
        findAlbumButton.clipsToBounds = true
        findAlbumButton.backgroundColor = .systemBlue
        albumInfo.text  = getAlbumInfoText()
        findAlbumButton.setTitle("Find On Apple Music", for: .normal)
        findAlbumButton.addTarget(self, action: #selector(goToAppleMusic), for: .touchUpInside)
    }
    
    func getAlbumInfoText() -> String {
        return "Artist : \(albumResult.artistName ?? "") \n\nAlbum : \(albumResult.name ?? "") \n\nGenre : \(getGenres()) \nRelease Date : \(albumResult.releaseDate ?? "") \n\nCopright : \(albumResult.copyright ?? "")"
    }
    
    func getGenres() -> String {
        return albumResult.genres?.map {get(genre: $0)}.joined(separator: ", ") ?? ""
    }
    
    func get(genre: Genre) -> String {
        return genre.name ?? ""
    }
    
    @objc func goToAppleMusic() {
        if let  urlString = albumResult.url, let requestUrl = URL(string: urlString)  {
            let safari = SFSafariViewController(url: requestUrl)
            present(safari, animated: true, completion: nil)
        }
    }
}
