import XCTest
import class Foundation.Bundle

extension String: Error {}

final class BekkerTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.

        // Some of the APIs that we use below are available in macOS 10.13 and above.
        guard #available(macOS 10.13, *) else {
            return
        }

        let bekker = productsDirectory.appendingPathComponent("Bekker")

        let process = Process()
        process.executableURL = bekker
        
        // https://github.com/apple/swift-package-manager/pull/2817
        guard let path = Bundle.module.path(forResource: "aristot.nic.eth_gk", ofType: "xml") else {
            throw "XML not found"
        }
        
        process.arguments = ["--input", path]

        let pipe = Pipe()
        process.standardOutput = pipe

        try process.run()
        process.waitUntilExit()

        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: data, encoding: .utf8)

        XCTAssertEqual(output, """
- [[aristot.nic.eth_gk 1, 1094a1]] πᾶσα τέχνη καὶ πᾶσα μέθοδος, ὁμοίως δὲ πρᾶξίς τε καὶ προαίρεσις, ἀγαθοῦ τινὸς ἐφίεσθαι δοκεῖ· διὸ καλῶς ἀπεφήναντο τἀγαθόν, οὗ πάντʼ ἐφίεται. διαφορὰ δέ τις φαίνεται τῶν τελῶν· τὰ μὲν γάρ εἰσιν ἐνέργειαι, τὰ δὲ παρʼ αὐτὰσ
- [[aristot.nic.eth_gk 1, 1094a5]] ἔργα τινά. ὧν δʼ εἰσὶ τέλη τινὰ παρὰ τὰς πράξεις, ἐν τούτοις βελτίω πέφυκε τῶν ἐνεργειῶν τὰ ἔργα. πολλῶν δὲ πράξεων οὐσῶν καὶ τεχνῶν καὶ ἐπιστημῶν πολλὰ γίνεται καὶ τὰ τέλη· ἰατρικῆς μὲν γὰρ ὑγίεια, ναυπηγικῆς δὲ πλοῖον, στρατηγικῆς δὲ νίκη, οἰκονομικῆς δὲ πλοῦτος. ὅσαι
- [[aristot.nic.eth_gk 1, 1094a10]] δʼ εἰσὶ τῶν τοιούτων ὑπὸ μίαν τινὰ δύναμιν, καθάπερ ὑπὸ τὴν ἱππικὴν χαλινοποιικὴ καὶ ὅσαι ἄλλαι τῶν ἱππικῶν ὀργάνων εἰσίν, αὕτη δὲ καὶ πᾶσα πολεμικὴ πρᾶξις ὑπὸ τὴν στρατηγικήν, κατὰ τὸν αὐτὸν δὴ τρόπον ἄλλαι ὑφʼ ἑτέρας· ἐν ἁπάσαις δὲ τὰ τῶν ἀρχιτεκτονικῶν τέλη πάντων
- [[aristot.nic.eth_gk 1, 1094a15]] ἐστὶν αἱρετώτερα τῶν ὑπʼ αὐτά· τούτων γὰρ χάριν κἀκεῖνα διώκεται. διαφέρει δʼ οὐδὲν τὰς ἐνεργείας αὐτὰς εἶναι τὰ τέλη τῶν πράξεων ἢ παρὰ ταύτας ἄλλο τι, καθάπερ ἐπὶ τῶν λεχθεισῶν ἐπιστημῶν. εἰ δή τι τέλος ἐστὶ τῶν πρακτῶν ὃ δῐ αὑτὸ βουλόμεθα, τἆλλα δὲ διὰ τοῦτο, καὶ μὴ
- [[aristot.nic.eth_gk 1, 1094a20]] πάντα δῐ ἕτερον αἱρούμεθαπρόεισι γὰρ οὕτω γʼ εἰς ἄπειρον, ὥστʼ εἶναι κενὴν καὶ ματαίαν τὴν ὄρεξιν, δῆλον ὡς τοῦτʼ ἂν εἴη τἀγαθὸν καὶ τὸ ἄριστον. ἆρʼ οὖν καὶ πρὸς τὸν βίον ἡ γνῶσις αὐτοῦ μεγάλην ἔχει ῥοπήν, καὶ καθάπερ τοξόται σκοπὸν ἔχοντες μᾶλλον ἂν τυγχάνοιμεν τοῦ δέοντος; εἰ δʼ
- [[aristot.nic.eth_gk 1, 1094a25]] οὕτω, πειρατέον τύπῳ γε περιλαβεῖν αὐτὸ τί ποτʼ ἐστὶ καὶ τίνος τῶν ἐπιστημῶν ἢ δυνάμεων. δόξειε δʼ ἂν τῆς κυριωτάτης καὶ μάλιστα ἀρχιτεκτονικῆς. τοιαύτη δʼ ἡ πολιτικὴ φαίνεται· τίνας γὰρ εἶναι χρεὼν τῶν ἐπιστημῶν ἐν ταῖς πόλεσι,
- [[aristot.nic.eth_gk 1, 1094b1]] καὶ ποίας ἑκάστους μανθάνειν καὶ μέχρι τίνος, αὕτη διατάσσει· ὁρῶμεν δὲ καὶ τὰς ἐντιμοτάτας τῶν δυνάμεων ὑπὸ ταύτην οὔσας, οἷον στρατηγικὴν οἰκονομικὴν ῥητορικήν· χρωμένης δὲ ταύτης ταῖς λοιπαῖσπρακτικαῖστῶν ἐπιστημῶν,
- [[aristot.nic.eth_gk 1, 1094b5]] ἔτι δὲ νομοθετούσης τί δεῖ πράττειν καὶ τίνων ἀπέχεσθαι, τὸ ταύτης τέλος περιέχοι ἂν τὰ τῶν ἄλλων, ὥστε τοῦτʼ ἂν εἴη τἀνθρώπινον ἀγαθόν. εἰ γὰρ καὶ ταὐτόν ἐστιν ἑνὶ καὶ πόλει, μεῖζόν γε καὶ τελειότερον τὸ τῆς πόλεως φαίνεται καὶ λαβεῖν καὶ σῴζειν· ἀγαπητὸν μὲν γὰρ καὶ ἑνὶ
- [[aristot.nic.eth_gk 1, 1094b10]] μόνῳ, κάλλιον δὲ καὶ θειότερον ἔθνει καὶ πόλεσιν. ἡ μὲν οὖν μέθοδος τούτων ἐφίεται, πολιτική τις οὖσα. λέγοιτο δʼ ἂν ἱκανῶς, εἰ κατὰ τὴν ὑποκειμένην ὕλην διασαφηθείη· τὸ γὰρ ἀκριβὲς οὐχ ὁμοίως ἐν ἅπασι τοῖς λόγοις ἐπιζητητέον, ὥσπερ οὐδʼ ἐν τοῖς δημιουργουμένοις. τὰ δὲ καλὰ καὶ τὰ δίκαια,
- [[aristot.nic.eth_gk 1, 1094b15]] περὶ ὧν ἡ πολιτικὴ σκοπεῖται, πολλὴν ἔχει διαφορὰν καὶ πλάνην, ὥστε δοκεῖν νόμῳ μόνον εἶναι, φύσει δὲ μή. τοιαύτην δέ τινα πλάνην ἔχει καὶ τἀγαθὰ διὰ τὸ πολλοῖς συμβαίνειν βλάβας ἀπʼ αὐτῶν· ἤδη γάρ τινες ἀπώλοντο διὰ πλοῦτον, ἕτεροι δὲ δῐ ἀνδρείαν. ἀγαπητὸν οὖν περὶ τοιούτων
- [[aristot.nic.eth_gk 1, 1094b20]] καὶ ἐκ τοιούτων λέγοντας παχυλῶς καὶ τύπῳ τἀληθὲς ἐνδείκνυσθαι, καὶ περὶ τῶν ὡς ἐπὶ τὸ πολὺ καὶ ἐκ τοιούτων λέγοντας τοιαῦτα καὶ συμπεραίνεσθαι. τὸν αὐτὸν δὴ τρόπον καὶ ἀποδέχεσθαι χρεὼν ἕκαστα τῶν λεγομένων· πεπαιδευμένου γάρ ἐστιν ἐπὶ τοσοῦτον τἀκριβὲς ἐπιζητεῖν καθʼ ἕκαστον

""")
    }

    /// Returns path to the built products directory.
    var productsDirectory: URL {
      #if os(macOS)
        for bundle in Bundle.allBundles where bundle.bundlePath.hasSuffix(".xctest") {
            return bundle.bundleURL.deletingLastPathComponent()
        }
        fatalError("couldn't find the products directory")
      #else
        return Bundle.main.bundleURL
      #endif
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
