//
//  MovieCatalogTests.swift
//  MovieCatalogTests
//
//  Created by Bruno Maciel on 2/24/24.
//

import XCTest
@testable import MovieCatalog

final class MovieCatalogTests: XCTestCase {
    
    var sut: HomeViewModel!
    var coordinator: HomeCoordinatorMock!
    var service: HomeServiceMock!

    override func setUp() {
        super.setUp()
        coordinator = HomeCoordinatorMock()
        service = HomeServiceMock()
        sut = HomeViewModel(coordinator: coordinator, service: service)
    }

    override func tearDown() {
        sut = nil
        coordinator = nil
        service = nil
        super.tearDown()
    }

    func test_loadMovies() {
        let state = sut.statePublisher.asRecorder()
        
        sut.loadMovies()
        
        XCTAssertTrue(service.fetchMoviesCalled)
        XCTAssert(state.values == [.loading(true), .loading(false), .movies([])])
    }
    
    func test_tryAgainLoading() {
        let state = sut.statePublisher.asRecorder()
        let section = 0
        sut.movieSections = [[], []]
        
        sut.tryAgainLoading(section: section)
        
        XCTAssertTrue(service.fetchMoviesSectionCalled)
        XCTAssert(state.values == [.loading(true), .loading(false), .updateSection(section, [])])
    }
    
    func test_sectionTitle() {
        let section = 0
        
        let sectionTitle = sut.sectionTitle(for: section)
        
        XCTAssertEqual(sectionTitle, "Movie List 0")
    }
    
    func test_selectPosterAt_whenVoteAvarageIs6() {
        sut.movieSections = [[MoviewMock.mock(voteAverage: 6)]]
        
        sut.selectPosterAt(section: 0, row: 0)
        
        XCTAssertTrue(coordinator.presentDetailsCalled)
    }
    
    func test_selectPosterAt_whenVoteAvarageIsLessThan6() {
        let state = sut.statePublisher.asRecorder()
        sut.movieSections = [[MoviewMock.mock(voteAverage: 5.9)]]
        
        sut.selectPosterAt(section: 0, row: 0)
        
        XCTAssertEqual(state.values, [.lowQualityContent])
    }

}
