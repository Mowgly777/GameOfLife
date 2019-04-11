
import Foundation
import XCTest

/*
 Valid board:
 1) square (10*10)
 2) bool
 */

func getBoard(size: Int)-> [[Bool]]?{
    if size > 0 {
        let board: [[Bool]] = Array(repeating: Array(repeating: false, count: size), count: size)
        return board
    } else {
        return nil
    }
}
//******************************  Tests  *************************
class Tests: XCTestCase{
    func testBoard(){
        print("\n*** Get Board test ***")
        var board: [[Bool]]?
        board = getBoard(size: 10)
        
        if let unwrappedBoard = board {
            XCTAssert(unwrappedBoard.count == unwrappedBoard[0].count && unwrappedBoard.count == 10)
        } else {
            XCTAssert(false)
        }
        
        board = getBoard(size: -1)
        
        XCTAssert(board == nil)
    }
}

XCTestSuite.default.run()
