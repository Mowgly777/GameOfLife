import Foundation
import XCTest

class Board {
    let boardSize: Int
    var board: [[Bool]] = []
    
    init() {
        boardSize = 10
        board = Array(repeating: Array(repeating: false, count: boardSize), count: boardSize)
    }
    
    init(size: Int) {
        boardSize = size
        board = Array(repeating: Array(repeating: false, count: boardSize), count: boardSize)
    }
    
    func getBoard() -> [[Bool]] {
        return board
    }
    
    func populateBoard(population: Int) {
        var populatedCoordinates: [Set<Int>] = []
        
        var populationWanted = 0
        while (populationWanted < population) {
            let randomY = Int.random(in: 0..<boardSize)
            let randomX = Int.random(in: 0..<boardSize)
            let coordinates: Set = [randomY, randomX]
            
            if (!populatedCoordinates.contains(coordinates)) {
                self.board[randomY][randomX] = true
                populatedCoordinates.append(coordinates)
                populationWanted += 1
            }
        }
    }
}


/*
 A valid board is 10x10 and consists of boolean values
 */
class testValidBoard: XCTestCase {
    func testBoard(){
        print("\n*** Get Board test ***")
        let size = 10
        let testBoard = Board(size: size)
        let testBoardArray = testBoard.getBoard()
        
        XCTAssert(testBoardArray.count == testBoardArray[0].count && testBoardArray.count == size)
        
        }
    
    func testValidBoard() {
        let testBoard = Board()
        let testBoardArray = testBoard.getBoard()
        
        let comparisonArray = Array(repeating: Array(repeating: false, count: 10), count: 10)
        XCTAssertEqual(comparisonArray, testBoardArray)
    }
    
    func testBoardPopulation() {
        let testBoard = Board()
        var testBoardArray: [[Bool]] = testBoard.getBoard()
        
        let populationWanted = 10
        testBoard.populateBoard(population: populationWanted)
        testBoardArray = testBoard.getBoard()
        
        var populationFound = 0
        for column in testBoardArray {
            for row in column {
                if (row == true) {
                    populationFound += 1
                }
            }
        }
        
        XCTAssertEqual(populationWanted, populationFound)
    }
}

XCTestSuite.default.run()
