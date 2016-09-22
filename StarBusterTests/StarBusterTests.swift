//
//  StarBusterTests.swift
//  StarBusterTests
//
//  Created by Matthew Ringer on 7/22/16.
//  Copyright © 2016 Matthew Ringer. All rights reserved.
//

import XCTest
import SpriteKit
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
    
    func test_CGFloat_Values() {
        
        let val1:CGFloat = 2.1
        let val2:CGFloat = GameLayer.Enemy
        
        XCTAssertEqual(val1, val2)
    }
    
    
//    func test_zPossition_Fails_Equivalence() {
//
//        let sprite:SKSpriteNode = SKSpriteNode()
//        let zPos:CGFloat = 2.1
//        
//        sprite.zPosition = zPos
//        
//        XCTAssertEqual(sprite.zPosition, zPos)
//    }
    
    
    func test_zPossition_Passes_Equivalence() {
        
        let sprite:SKSpriteNode = SKSpriteNode()
        let zPos:CGFloat = 2
        
        sprite.zPosition = zPos
        
        XCTAssertEqual(sprite.zPosition, zPos)
    }
    
    func test_CGFloat_Passes_Equivalence() {
        
        let zPosA:CGFloat = 2.1
        let zPosB:CGFloat = 2.1
        
        XCTAssertEqual(zPosA, zPosB)
    }

    
    
    func testEnemy_init_state() {
        // Arrange
        let enemy:Enemy = Enemy()
        
        // Act
        
        // Assert Round is necessary because zPosition values are Imprecise
        XCTAssertEqual(round(enemy.zPosition), round(GameLayer.Enemy))
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
