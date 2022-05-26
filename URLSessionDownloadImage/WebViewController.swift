//
//  WebViewController.swift
//  Networking
//
//  Created by Alexander Muller on 26.05.2022.


import UIKit
import WebKit

class WebViewController: UIViewController {
    
    var selectedCourse: String?
    var courseURL = ""
    
    var progressView : UIProgressView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        
        return $0
    }(UIProgressView(progressViewStyle: .default))
    
    var webView : WKWebView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        
        return $0
    }(WKWebView(frame: .zero))
    
    override func loadView() {
        super.loadView()
        setupConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = selectedCourse
        
        guard let url = URL(string: courseURL) else { return }
        let request = URLRequest(url: url)
        
        webView.load(request)
        webView.allowsBackForwardNavigationGestures = true
        webView.navigationDelegate = self
        webView.addObserver(self,
                            forKeyPath: #keyPath(WKWebView.estimatedProgress),
                            options: .new,
                            context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {
        
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    private func showProgressView() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            self.progressView.alpha = 1
        }, completion: nil)
    }
    
    private func hideProgressView() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            self.progressView.alpha = 0
        }, completion: nil)
    }
}

extension WebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        showProgressView()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        hideProgressView()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        hideProgressView()
    }
}

extension WebViewController {
    private func setupConstraints() {
        view.addSubview(progressView)
        view.addSubview(webView)
        
        progressView.translatesAutoresizingMaskIntoConstraints = false
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            progressView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: progressView.trailingAnchor),
            
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: webView.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: webView.bottomAnchor)
        ])
    }
}
