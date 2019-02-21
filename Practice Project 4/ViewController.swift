import WebKit
import UIKit


class ViewController: UIViewController, WKNavigationDelegate {
    //parent class = UIViewControoller, using the WKNavigationDelegate protocol
    
    var webView: WKWebView!
    
    var progressView: UIProgressView!
    
    var websites = ["apple.com", "hackingwithswift.com"]
    
    
    //use override b/c the default implementation is to load the layout from the storyboard
    override func loadView() {
        webView = WKWebView()
        
        webView.navigationDelegate = self
        //setting the webView's navdeligate to self means when any web page navigation happens, tell the current view controller
        view = webView
        //making the root view the web view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://" + websites[0])!
        webView.load(URLRequest(url: url))
        //loading the web view - WKWebViews dont load websites from strings - you need to turn the string into a url then put the url into an URLRequest
        webView.allowsBackForwardNavigationGestures = true
        //enables users to swipe from left or right edge to browse
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        
        //creating a new UIProgressView instance w/ default style and setting its layout size
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        
        //creating a new UIBarButtonItem w/ customView parameter - wrapped UIProgressView in a UIBarButtonItem so it can go into the tollbar
        let progressButton = UIBarButtonItem(customView: progressView)
        
        
        //creating a new bar button item using .flexibleSpace
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        
        
        toolbarItems = [progressButton,spacer, refresh]
        
        navigationController?.isToolbarHidden = false
        
        
        //using key-value observing(KVO) to watch the estimatedProgress property
        //4 parameters - who the observer is, what property to observe, which value, and context value
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        //usually match with removeObserver()
        
        
        
        
    }
    
    @objc func openTapped(){
        let ac = UIAlertController(title: "Open page..", message: nil, preferredStyle: .actionSheet)
        //nil for message because alert doesnt need one
        //.actionSheet to prompt the user for more info
        for website in websites {
            ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
        }
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        //adding a dedicated cancel button - no handler meaning iOS will just hide the alert controller if tapped
        ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem //for iPad
        present(ac, animated: true)
    }
    
    func openPage(action: UIAlertAction) {
        let url = URL(string: "https://" + action.title!)!
        webView.load(URLRequest(url: url))
    }
    //only parameter of this method is the UIAlertAction object that was selected by the user - wont be called if Cancel is tapped because that had a nil handler
    //method's purpose is to satisfy app transport security by adding https
    
    
    //putting the name of the website as the title
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    //using an observer w/ KVO requires an observeValue method
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    //deciding whether to allow navigation to happen
    //decisionHandler is a closure(actually has the potential to be an escaping closure)
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        let url = navigationAction.request.url
        
        if let host = url?.host {
            for website in websites {
                if host.contains(website){
                    decisionHandler(.allow)
                    return
                }
            }
        }
        decisionHandler(.cancel)
    }

}

