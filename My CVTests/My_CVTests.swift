//
//  My_CVTests.swift
//  My CVTests
//
//  Created by Nick Nick  on 4/28/19.
//  Copyright © 2019 IndieApps. All rights reserved.
//

import XCTest
@testable import My_CV

class My_CVTests: XCTestCase {

    //If this test fails, it means that separation chracters/logic was modified in  splitOnLines() fucntion. If test passes but separation is still wrong check your  text's own punctuation.
    func testSplitOnLines() {
        let sampleText = "My name is: Nickita. I am 21."
        let editedText = sampleText.splitOnLines().components(separatedBy: "\n\n")
        let separationCharactersCount = sampleText.filter { (separationCharacter) -> Bool in
            return (separationCharacter == Character(".") ||  separationCharacter == Character(":"))
        }
        XCTAssertEqual(editedText.count, separationCharactersCount.count)
    }
    
}
