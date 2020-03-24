//
//  nike_coding_test_2Tests.swift
//  nike coding test 2Tests
//
//  Created by Chaitu Bk on 3/22/20.
//  Copyright © 2020 Chaitu Bk. All rights reserved.
//

import XCTest
@testable import nike_coding_test_2

class nike_coding_test_2Tests: XCTestCase {
    
    var mockAlbumInfo: TopHundredAlbumData?
    var mockAlbumVC: albumVC?
    var mockAlbumInfoVC: albumInformationVC?
    
    override func setUp() {
        if let path = Bundle.main.path(forResource: "rssMockData", ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                let data = (try? Data(contentsOf: fileUrl)) ?? Data()
                let albumData = try JSONDecoder().decode(Feed.self, from: data)
                mockAlbumInfo = TopHundredAlbumData(topHundredAlbumInfo: albumData.feed)
                mockAlbumVC = albumVC()
                mockAlbumVC?.albumInfo = mockAlbumInfo
                mockAlbumVC?.setupAlbumTable()
                mockAlbumVC?.albumTable.reloadData()
            }catch {
                // error
            }
            
        }
        super.setUp()
    }
    
    override func tearDown() {
        mockAlbumInfo = nil
        super.tearDown()
    }
    
    func testNumberOfRows() {
        XCTAssertEqual(mockAlbumVC?.albumTable.numberOfRows(inSection: 0), mockAlbumInfo?.albumFeed?.results?.count)
    }
    
    func testCellForARow() {
        let expectedCell = self.mockAlbumVC?.albumTable.cellForRow(at: IndexPath(row: 0, section: 0)) as? albumCell
        let expectedResult = self.mockAlbumInfo?.albumFeed?.results?[0]
        XCTAssertEqual(expectedCell?.albumNameLable.text, expectedResult?.name)
        XCTAssertEqual(expectedCell?.artistNameLable.text, expectedResult?.artistName)
        XCTAssertNotNil(expectedCell?.albumArt)
    }
    
    func testForAlbumInfoVC() {
        guard let selectedInfo = mockAlbumInfo?.albumFeed?.results?.first else {return}
        let mockAlbumInfoVC = albumInformationVC(albumResult: selectedInfo)
        mockAlbumInfoVC.viewDidLoad()
        XCTAssertNotNil(mockAlbumInfoVC)
        XCTAssertNotNil(mockAlbumInfoVC.albumArt)
        XCTAssertNotNil(mockAlbumInfoVC.albumInfo)
    }
    
}
