
import Foundation
import XCTest

/*
 Valid board:
 1) square (n*n)
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

func underPopDeath(board: [[Bool]])-> [[Bool]]{
    var newBoard = board
    
    for (i, row) in board.enumerated(){
        for (j, value) in row.enumerated(){
                if value {
                var cnt = 0
                for i_offset in 0..<3{
                    for j_offset in  0..<3{
                        if j-1+j_offset >= 0 && j-1+j_offset < board.count &&
                            i-1+i_offset >= 0 && i-1+i_offset < board.count &&
                            !(j_offset == 1 && i_offset == 1){
                            if board[i-1+i_offset][j-1+j_offset] {
                                cnt+=1
                            }
                        }
                    }
                }
                if cnt < 2{
                    newBoard[i][j] = false
                }
            }
        }
    }
    return newBoard
}

func overPopDeath(board: [[Bool]])-> [[Bool]]{
    var newBoard = board
    
    for (i, row) in board.enumerated(){
        for (j, value) in row.enumerated(){
            if value {
                var cnt = 0
                for i_offset in 0..<3{
                    for j_offset in  0..<3{
                        if j-1+j_offset >= 0 && j-1+j_offset < board.count &&
                            i-1+i_offset >= 0 && i-1+i_offset < board.count &&
                            !(j_offset == 1 && i_offset == 1){
                            if board[i-1+i_offset][j-1+j_offset] {
                                cnt+=1
                            }
                        }
                    }
                }
                if cnt > 2{
                    newBoard[i][j] = false
                }
            }
        }
    }
    return newBoard
}

func popGrowth(board: [[Bool]])-> [[Bool]]{
    var newBoard = board
    
    for (i, row) in board.enumerated(){
        for (j, value) in row.enumerated(){
            if !value {
                var cnt = 0
                for i_offset in 0..<3{
                    for j_offset in  0..<3{
                        if j-1+j_offset >= 0 && j-1+j_offset < board.count &&
                            i-1+i_offset >= 0 && i-1+i_offset < board.count &&
                            !(j_offset == 1 && i_offset == 1){
                            if board[i-1+i_offset][j-1+j_offset] {
                                cnt+=1
                            }
                        }
                    }
                }
                if cnt == 3{
                    newBoard[i][j] = true
                }
            }
        }
    }
    return newBoard
}

func gameItteration( board: [[Bool]] )-> [[Bool]]{
    
    var newBoard = board
    var cnt = 0
    for (i, row) in board.enumerated(){
        for (j, _) in row.enumerated(){
            cnt = 0
            for i_offset in 0..<3{
                for j_offset in  0..<3{
                    if j-1+j_offset >= 0 && j-1+j_offset < board.count &&
                        i-1+i_offset >= 0 && i-1+i_offset < board.count &&
                        !(j_offset == 1 && i_offset == 1){
                        if board[i-1+i_offset][j-1+j_offset] {
                            cnt+=1
                        }
                    }
                }
            }
            if cnt < 2{
                newBoard[i][j] = false
            } else if cnt == 3{
                newBoard[i][j] = true
            } else if cnt > 3{
                newBoard[i][j] = false
            }
        }
    }
    
    return newBoard
}

func runGame(boardSize: Int) -> [[Bool]]?{
    
    let initialGameBoard = getBoard(size: boardSize)
        if var gameBoard = initialGameBoard{
        var newBoard = gameBoard
        
        repeat{
            gameBoard = newBoard
            newBoard = gameItteration(board: gameBoard)
        } while newBoard != gameBoard
        
        return newBoard
    }
    
    return nil
}

//******************************  Tests  *************************
class Tests: XCTestCase{
    func testBoard(){
        print("\n*** Get Board Test ***")
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
    
    func testRule1(){
        print("\n*** Rule 1 Test ***")
        
        let initialBoard = [[true, true, false, false],
                            [false, false, false, false],
                            [false, false, false, false],
                            [false, false, false, false]]
        let finalBoardMock = [[false, false, false, false],
                              [false, false, false, false],
                              [false, false, false, false],
                              [false, false, false, false]]
        
        let board = underPopDeath(board: initialBoard)
        XCTAssert(board == finalBoardMock)
    }
    
    func testRule3(){
        print("\n*** Rule 3 Test ***")
        
        let initialBoard = [[true, true, true, false],
                            [false, true, false, false],
                            [false, false, false, false],
                            [false, false, false, false]]
        let finalBoardMock = [[true, false, true, false],
                              [false, false, false, false],
                              [false, false, false, false],
                              [false, false, false, false]]
        
        let board = overPopDeath(board: initialBoard);
        XCTAssert(board == finalBoardMock)
        
    }
    
    func testRule4(){
        print("\n*** Rule 4 Test ***")
        
        let initialBoard = [[true, true, true, false],
                            [false, true, false, false],
                            [false, false, false, false],
                            [false, false, false, false]]
        let finalBoardMock = [[true, true, true, false],
                              [true, true, true, false],
                              [false, false, false, false],
                              [false, false, false, false]]
        
        let board = popGrowth(board: initialBoard);
        XCTAssert(board == finalBoardMock)
    }
    
    func testGameItteration(){
        print("\n*** Game Itteration Test ***")
        
        let initialBoard = [[true, true, true, false],
                            [false, true, false, false],
                            [false, false, false, false],
                            [false, false, false, false]]
        
        let finalBoardMock = [[true, true, true, false],
                              [true, true, true, false],
                              [false, false, false, false],
                              [false, false, false, false]]
        
        let board = gameItteration(board: initialBoard)
        
        XCTAssert(board == finalBoardMock)
    }
    
    func testFullGame(){
        print("\n*** Full Game Test ***")
        
        let board = runGame(boardSize: 4)
        if let unwrappedBoard = board{
            XCTAssert(board == gameItteration(board: unwrappedBoard))
        }
    }
}

XCTestSuite.default.run()
