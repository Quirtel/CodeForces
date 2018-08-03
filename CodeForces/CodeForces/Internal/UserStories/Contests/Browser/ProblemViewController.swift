import Foundation
import SwiftSoup
import Reusable
import WebKit

class ProblemViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView = WKWebView()
    var backgroundTasks = DispatchQueue(label: "background")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let margins = view.layoutMarginsGuide
        webView.navigationDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        webView.topAnchor.constraint(equalTo:  view.topAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func configure(with model: TaskCellModel) {
        backgroundTasks.async {
            let url = URL(string: "https://www.codeforces.com/contest/\(model.contestId)/problem/\(model.index)?mobile=true")!
            
            let request = URLRequest(url: url)
            
            do {
                let html = try String(contentsOf: url, encoding: .utf8)
                
                let doc: Document = try SwiftSoup.parse(html)
                
                try doc.getElementsByClass("second-level-menu").first()?.remove()
                try doc.getElementsByClass("roundbox menu-box").first()?.remove()
                try doc.getElementsByClass("lang-chooser").first()?.remove()
                try doc.getElementsByClass("menu-box").first()?.remove()
                try doc.getElementsByClass("mobile-toolbar").first()?.remove()
                try doc.getElementById("swipe-sidebar")?.remove()
                try doc.head()?.append("""
                <style>div.ttypography p {font-size: 1.7em}
                .problem-statement .sample-tests pre {font-size: 1.7em}
                .problem-statement .sample-tests .title {font-size: 1.7em}
                .problem-statement .time-limit, .problem-statement .memory-limit,
                .problem-statement .input-file, .problem-statement .output-file {font-size: 1.13em}
                .problem-statement .header .title {font-size: 1.9em}
                </style>
                """
                )
                
                DispatchQueue.main.async {
                    do {
                        self.webView.loadHTMLString(try doc.html(), baseURL: url)
                    }
                    catch (let error) {
                        print(error)
                    }
                }
            }
            catch (let error) {
                print(error)
            }
        }
    }
}
