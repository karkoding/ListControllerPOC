//
//  XCTestCase+MemoryLeakTracking.swift
//  EssentialFeedTests
//
//  Created by Karthik K Manoj on 29/04/21.
//

import XCTest

extension XCTestCase {
    func trackForMemoryLeak(_ instance: AnyObject,  file: StaticString = #filePath, line: UInt = #line) {
        addTeardownBlock {  [weak instance] in
            XCTAssertNil(instance, "Instance should have been deallocated. Potential memory leak.", file: file, line: line)
        }
    }
}
