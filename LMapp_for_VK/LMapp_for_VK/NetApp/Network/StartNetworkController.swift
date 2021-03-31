//
//  StartNetworkController.swift
//  LMapp_for_VK
//
//  Created by Максим Лосев on 01.02.2021.
//

import UIKit
import WebKit

class StartNetworkController: UIViewController {
    
    @IBOutlet weak var webview: WKWebView!{
        didSet{
            webview.navigationDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let networkManager = NetworkManager()
        networkManager.authorize(webview)

    }
    
}

extension StartNetworkController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment  else {
            decisionHandler(.allow)
            return
        }

        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
        }

        guard let token = params["access_token"] else { return }
        guard let userId = params["user_id"] else { return }
        NetSession.instance.token = token
        NetSession.instance.userId = Int(userId) ?? 0
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(identifier: "NetFriendsListController")
        show(controller, sender: nil)
        
        decisionHandler(.cancel)
        
    }
}
