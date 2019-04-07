//
//  ViewController.swift
//  rush00
//
//  Created by Clementine URQUIZAR on 3/29/19.
//  Copyright © 2019 Clementine URQUIZAR. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {
    
    let activityIndicator : UIActivityIndicatorView = UIActivityIndicatorView()
    
    @IBOutlet weak var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
            webView.uiDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // CSS
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        // Nav
        title = "Authorization"
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = true
        
        setWebView()
    }
    
    func setWebView() {
        print("setWebView")
        guard let uid = ProcessInfo.processInfo.environment["42_UID"] else { return }
        
        let queryItems = [
            URLQueryItem(name: "client_id", value: uid),
            URLQueryItem(name: "redirect_uri", value: "https://www.42.fr/"),
            URLQueryItem(name: "scope", value: "public forum"),
            URLQueryItem(name: "state", value: "18HN5ighCuDF10tt925ej3emB0hgkM2navxxfBgOEwkNk711J44fFe6JAPp8UXsj"),
            URLQueryItem(name: "response_type", value: "code")
        ]
        var component = URLComponents(string: "https://api.intra.42.fr/oauth/authorize")!
        component.queryItems = queryItems as [URLQueryItem]
        let url: URL = component.url!
        print(url)
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"

        webView.load(request as URLRequest)
    }
    
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        print("didReceiveServerRedirectForProvisionalNavigation")
        print(webView.url!)
                
        if (webView.url!.absoluteString.contains("?code=")){
            print(webView.url!)
            webView.stopLoading()
        }

        guard let url = URLComponents(string: (webView.url?.absoluteString)!) else { return }
        guard let code = url.queryItems?.first(where: { $0.name == "code" })?.value else { return }
        guard let state = url.queryItems?.first(where: { $0.name == "state" })?.value else { return }
        guard let uid = ProcessInfo.processInfo.environment["42_UID"] else { return }
        guard let secret = ProcessInfo.processInfo.environment["42_SECRET"] else { return }
        
        print("code = \(code)")
        
        let queryItems = [
            URLQueryItem(name: "grant_type", value: "authorization_code"),
            URLQueryItem(name: "client_id", value: uid),
            URLQueryItem(name: "client_secret", value: secret),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "redirect_uri", value: "https://www.42.fr/"),
            URLQueryItem(name: "state", value: state),
        ]
        var component = URLComponents(string: "https://api.intra.42.fr/oauth/token")!
        component.queryItems = queryItems as [URLQueryItem]
        let urlForToken: URL = component.url!
        print(urlForToken)
        
        let request = NSMutableURLRequest(url: urlForToken)
        request.httpMethod = "POST"
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {(data,res,err) in
            if let e = err {
                print(e)
            } else if let d = data {
                do {
                    if let dic: NSDictionary = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                        if let accessToken = dic["access_token"] as? String {
                            print("42 Token =", accessToken)
                            DispatchQueue.main.async {
                                self.goToTopicsView(token: accessToken)
                            }
                            
                        } else {
                            print("No token")
                        }
                    }
                }
                catch (let e) {
                    print(e)
                }
            }
        }
        task.resume()
    }
    
    func goToTopicsView(token: String) {
        // Redirect to new view
        let topicsViewController = self.storyboard?.instantiateViewController(withIdentifier: "topicsViewController") as! TopicsViewController
        topicsViewController.token = token
        self.navigationController?.pushViewController(topicsViewController, animated: true)
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!){
        // Hide activity & network indicator
        self.activityIndicator.stopAnimating()
    }
    
    @IBAction func undWindSegue(segue: UIStoryboardSegue) {
        print("unwindSegue")
        if segue.identifier == "logoutSegue" {
            let dataStore = WKWebsiteDataStore.default()
            dataStore.fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { (records) in
                for record in records {
                    if record.displayName.contains("42") {
                        dataStore.removeData(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes(), for: [record], completionHandler: {
                            print("Deleted: " + record.displayName);
                            DispatchQueue.main.async {
//                                self.webView.reload()
                                self.setWebView()
                            }
                        })
                    }
                }
            }
        }
    }
}
