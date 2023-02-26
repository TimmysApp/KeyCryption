import XCTest
@testable import KeyCryption

final class KeyCryptionTests: XCTestCase {
    func testEncryptingAndEncoding() throws {
        let sut = Testy(id: UUID(), test: "Hi!", hi: "This is a test")
        let data = try! JSONEncoder().encode(sut)
        print(String(data: data, encoding: .utf8) ?? "")
        let new = try! CryptableDecoder().decode(Testy.self, from: data)
        print(new.test)
        XCTAssert(new.id == sut.id && new.test == sut.test && new.hi == sut.hi)
    }
}

struct Testy: CodeCryptable {
    static var key = "{Ef,&,pS0JVUnH:NM7*EvMEtd!,J9,7_"
    @Cryptable(key: key) var test: String = ""
    @Cryptable(key: key) var hi: String
    var id: UUID?
    init(id: UUID?, test: String, hi: String) {
        self._test.wrappedValue = test
        self._hi.wrappedValue = hi
    }
}
