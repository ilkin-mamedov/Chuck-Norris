import XCTest
@testable import Chuck_Norris

class Chuck_Norris_Tests: XCTestCase {
    
    func testJoke() {
        let jokeViewModel = JokeViewModel()
        
        jokeViewModel.fetchJoke()
        
        jokeViewModel.category.bind { value in
            XCTAssertNotNil(value)
        }
        
        jokeViewModel.joke.bind { value in
            XCTAssertNotNil(value)
        }
    }
    
    func testSearch() {
        let searchViewModel = SearchViewModel()
        
        searchViewModel.fetchJoke(by: "Dev")
        
        searchViewModel.category.bind { value in
            XCTAssertNotNil(value)
        }
        
        searchViewModel.joke.bind { value in
            XCTAssertNotNil(value)
        }
    }
    
    func testSubstring() {
        let searchViewModel = SearchViewModel()
        
        let text = searchViewModel.substring(text: "TestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTest")
        
        let result = "TestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTe..."
        
        XCTAssertEqual(text, result)
    }

}
