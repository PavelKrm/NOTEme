//
//  InputVlidatorTests.swift
//  NoteMeTests
//
//  Created by PavelKrm on 26.03.24.
//

import XCTest
@testable import NoteMe

final class InputValidatorTests: XCTestCase {
    
    func test_validEmail() {
        let sut = InputValidator()
        let validEmail = "test@test.com"
        
        let result = sut.validate(email: validEmail)
        
        XCTAssert(result)
    }
    
    func test_invalidEmail() {
        let sut = InputValidator()
        let invalidEmail = "test@@test.com"
        
        let result = sut.validate(email: invalidEmail)
        
        XCTAssertFalse(result)
    }
    
    func test_validDoubleExtensionEmail() {
        
        let sut = InputValidator()
        let validEmail = "test@test.com.by"
        
        let result = sut.validate(email: validEmail)
        
        XCTAssert(result)
    }
}
