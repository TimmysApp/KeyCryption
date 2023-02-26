import XCTest
@testable import KeyCryption

final class KeyCryptionTests: XCTestCase {
    func testExample() throws {
        let ob = Testy(test: "")
        let decrypted = ob.test
        ob.$test.decrypt()
        XCTAssert(decrypted == "Hi there!")
    }
}

struct Testy {
    @Cryptable(key: "{Ef,&,pS0JVUnH:NM7*EvMEtd!,J9,7_") var test: String
    init(test: String) {
        self.test = test
    }
}

