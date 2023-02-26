import XCTest
@testable import KeyCryption

final class KeyCryptionTests: XCTestCase {
    func testExample() throws {
        let ob = Testy(test: "Hi h", hi: "ergtrgre")
        let data = try! JSONEncoder().encode(ob)
        print(String(data: data, encoding: .utf8))
        let new = try! CryptableDecoder().decode(Testy.self, from: data)
        print(new.test)
        
    }
}

struct Testy: CodeCryptable {
    static var empty = Testy(test: "", hi: "")
    @Cryptable(key: "{Ef,&,pS0JVUnH:NM7*EvMEtd!,J9,7_") var test: String = ""
    @Cryptable(key: "{Ef,&,pS0JVUnH:NM7*EvMEtd!,J9,71") var hi: String
    init(test: String, hi: String) {
        self.test = test
        self.hi = hi
    }
}
