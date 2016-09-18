//
//  StarBusterTests.swift
//  StarBusterTests
//
//  Created by Matthew Ringer on 7/22/16.
//  Copyright © 2016 Matthew Ringer. All rights reserved.
//

import XCTest
@testable import StarBuster

class StarBusterTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testEnemy_init_state() {
        // Arrange
        let enemy:Enemy = Enemy()
        
        // Act
        
        // Assert
        XCTAssertEqual(enemy.zPosition, GameLayer.Enemy)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
