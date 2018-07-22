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
        
        let model = MoviesViewModel()
            model.page = 1
        XCTAssertEqual(model.page, 1)
        
        let url = String(format: Constant.BASE_URL+"popular?api_key="+Constant.API_KEY+"&page=\(model.page)")
        
        XCTAssertEqual(model.movies_url, url)
        
        XCTAssert(model.movies.count == 0)
        
        

        
        let movieDetails = MovieDetails(json: ["id":123, "popularity":92.6, "poster_path":"",     "release_date":"2018-7-22", "title":"Rajesh koyi",
            "runtime":120, "overview": "","genres": [],"languages":[]])
        
       
        model.movies.append(movieDetails)
        
        XCTAssert(model.movies.count > 0)
        
        XCTAssertEqual(model.movies.first?.id, 123)
        
        XCTAssertEqual(model.movies.first?.title, "Rajesh koyi")
       
              
    }
}
