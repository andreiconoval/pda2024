import UIKit
import WebKit

class PlayerWebViewController: UIViewController {

    public var SearchName: String!
    private let googleUrl = "https://www.google.com/search?q="
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let queryEncoded = SearchName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let url = URL(string: googleUrl + queryEncoded) {
            print(url.absoluteString)
            webView.load(URLRequest(url: url))
        } else {
            print("Failed to create URL")
        }
    }
}
