import UIKit
import XCTest

class Board {
    var board: [[Bool]] = Array(repeating: Array(repeating: false, count: 10), count: 10)
    func getBoard() -> [[Bool]] {
        return board
    }
    
    func populateBoard(population: Int) {
        for y in 0...board.count-1 {
            for x in 0...board.count-1 {
                if (board[y][x] == false) {
                    board[y][x] = true
                }
            }
        }
    }
}

    
/*
 A valid board is 10x10 and consists of boolean values
*/
class testValidBoard: XCTestCase {
    func testValidBoard() {
        let testBoard = Board()
        let testBoardArray = testBoard.getBoard()
        
        let comparisonArray = Array(repeating: Array(repeating: false, count: 10), count: 10)
        XCTAssertEqual(comparisonArray, testBoardArray)
    }
    
    func testBoardPopulation() {
        let testBoard = Board()
        
        testBoard.populateBoard(population: 10)
        
    }
}

XCTestSuite.default.run()

