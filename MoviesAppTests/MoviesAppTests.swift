//
//  MoviesAppTests.swift
//  MoviesAppTests
//
//  Created by techno krishna on 21/07/18.
//  Copyright © 2018 techno krishna. All rights reserved.
//

import XCTest
@testable import MoviesApp

class MoviesAppTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMoviesViewModel(){
        
        var model = MoviesViewModel(page: 1)
        
        XCTAssertEqual(model.page, 1)
        
        let url = String(format: Constant.BASE_URL+"popular?api_key="+Constant.API_KEY+"&page=\(model.page)")
        
        XCTAssertEqual(model.movies_url, url)
        
        XCTAssert(model.movies.count == 0)
        
        
        var entities = MovieEntities(json: ["page":1, "total_results": 100, "total_pages":10, "results":[]])
        var movieDetails = MovieDetails(json: ["id":123,"name":"Batman" ])
        model.movies.append(movieDetails)
        
        XCTAssert(model.movies.count > 0)
        
       XCTAssertEqual(model.movies.first?.id, 123)
       
              
    }
}
