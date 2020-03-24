//
//  albumVC.swift
//  nike coding test 2
//
//  Created by Chaitu Bk on 3/22/20.
//  Copyright © 2020 Chaitu Bk. All rights reserved.
//

import UIKit

class albumVC: UIViewController {
    
    var albumTable: UITableView = UITableView()
    var albumInfo: TopHundredAlbumData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAlbumTable()
        loadData()
    }
    
    func setupAlbumTable() {
        albumTable.delegate = self
        albumTable.dataSource = self
        albumTable.register(albumCell.self, forCellReuseIdentifier: "albumInfoCell")
        view.addSubview(albumTable)
        albumTable.pinTo(givenView: view)
    }
    
    private func loadData() {
        
        guard let urlString = URL(string: "https://rss.itunes.apple.com/api/v1/us/apple-music/top-albums/all/100/explicit.json"), self.albumInfo == nil else {return}
        let request = URLRequest(url: urlString)
        let task = URLSession.shared.dataTask(with: request) { (data:Data?, response:URLResponse?, error:Error?) in
            guard let data = data else {return}
            do {
                let albumData = try JSONDecoder().decode(Feed.self, from: data)
                self.albumInfo = TopHundredAlbumData(topHundredAlbumInfo: albumData.feed)
                DispatchQueue.main.async {
                    self.albumTable.reloadData()
                    self.title = self.albumInfo?.albumFeed?.title
                }
            }catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}

extension albumVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumInfo?.albumFeed?.results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let results = albumInfo?.albumFeed?.results, results.count >= indexPath.row, let cell = albumTable.dequeueReusableCell(withIdentifier: "albumInfoCell") as? albumCell else {return UITableViewCell()}
        let albumResult =  results[indexPath.row]
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.populateCellWith(artist: albumResult.artistName, album: albumResult.name, artWork: albumResult.artworkUrl100 ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let results = albumInfo?.albumFeed?.results, results.count >= indexPath.row else {return}
        let viewController = albumInformationVC(albumResult: results[indexPath.row])
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
