//
//  SermonViewController.swift
//  MyChurch_ver2
//
//  Created by 백승화 on 2020/05/03.
//  Copyright © 2020 백승화. All rights reserved.
//

import UIKit
import WebKit

class SermonViewController : UIViewController {
    
    @IBOutlet var sermonKind: UILabel!
    @IBOutlet var sermonTitle: UILabel!
    
    @IBOutlet var webView: WKWebView!
    @IBOutlet var webButton: UIButton!
    @IBOutlet var webLoading: UIActivityIndicatorView!
    
    @IBOutlet var sermonView: UIView!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var segment: UISegmentedControl!
    var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadVideo()
        loadScrollView()
        self.textView = UITextView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.scrollView.frame.height))
        scrollView.addSubview(textView)
        self.textView.text = "텍스트"
        self.textView.isEditable = false
        segment.addTarget(self, action: #selector(self.segmentedAction(_:)), for: .valueChanged)
    }
    
    @objc func segmentedAction(_ respond : UISegmentedControl) {
        if self.segment.selectedSegmentIndex == 0 {
            scrollView.contentOffset.x = 0
        }else if self.segment.selectedSegmentIndex == 1 {
            scrollView.contentOffset.x = self.view.frame.width
        }
    }
    
    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func closeVideo(_ sender: Any) {
        UIView.animate(withDuration: 0.3) {
            if self.webView.frame.height == 0 {
                UIView.animate(withDuration: 1, animations: {
                    self.webView.frame.size = CGSize(width: self.view.frame.width, height: 253)
                    self.sermonView.frame.origin.y = 368
                    self.sermonView.frame.size.height = 444
                    self.scrollView.frame.size.height = 398
                    self.textView.frame.size.height = 398
                }) { (_) in
                    self.webView.translatesAutoresizingMaskIntoConstraints = false
                    self.sermonView.translatesAutoresizingMaskIntoConstraints = false
                    self.scrollView.translatesAutoresizingMaskIntoConstraints = false
                    self.textView.translatesAutoresizingMaskIntoConstraints = false
                }
                
            }else {
                self.webView.translatesAutoresizingMaskIntoConstraints = true
                self.sermonView.translatesAutoresizingMaskIntoConstraints = true
                self.scrollView.translatesAutoresizingMaskIntoConstraints = true
                self.textView.translatesAutoresizingMaskIntoConstraints = true
                
                self.webView.frame.size = CGSize(width: self.view.frame.width, height: 0)
                self.sermonView.frame.origin.y = 112
                self.sermonView.frame.size.height = 657
                self.scrollView.frame.size.height = 657
                self.textView.frame.size.height = 657
            }
        }
    }

}

//MARK:-WebView & Delegate

extension SermonViewController : WKNavigationDelegate{
    func loadVideo() {
        self.webView.navigationDelegate = self
        webLoading.isHidden = false
        
        let webConfig = WKWebViewConfiguration()
        webConfig.allowsInlineMediaPlayback = true
        webConfig.mediaTypesRequiringUserActionForPlayback = []
        
        if let videoURL = URL(string: "https://www.youtube.com/embed/live_stream?channel=UC5PmuQM7rLMw5WwYDNCfWXw") {
             let request:URLRequest = URLRequest(url: videoURL)
             self.webView.load(request)
        }
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("start")
        webLoading.isHidden = false
        webLoading.startAnimating()
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("finish")
        webLoading.stopAnimating()
        webLoading.isHidden = true
    }
}

//MARK:-ScrollViewDelegate

extension SermonViewController : UIScrollViewDelegate {
    
    func loadScrollView() {
        self.scrollView.delegate = self
        self.scrollView.contentSize.width = self.view.frame.width*2
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x == 0 {
            self.segment.selectedSegmentIndex = 0
        }else if scrollView.contentOffset.x == self.view.frame.width {
            self.segment.selectedSegmentIndex = 1
        }
    }
}
