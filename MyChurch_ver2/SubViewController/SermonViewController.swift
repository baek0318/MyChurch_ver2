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
    var scrollView: UIScrollView!
    @IBOutlet var segment: UISegmentedControl!
    var tableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadVideo()
        loadScrollView()
        createTable()
        createSequence()
        sermonKind.text = "오전예배"
        sermonTitle.text = "제자 3대를 꿈꾸는 복된 가정"
        segment.addTarget(self, action: #selector(self.segmentedAction(_:)), for: .valueChanged)
    }
    
    @objc func segmentedAction(_ respond : UISegmentedControl) {
        if self.segment.selectedSegmentIndex == 0 {
            scrollView.contentOffset.x = 0
            tableView.alpha = 1
        }else if self.segment.selectedSegmentIndex == 1 {
            tableView.alpha = 0
            scrollView.contentOffset.x = self.view.frame.width
        }
    }
    
    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    //MARK:- Sermon Animation
    
    @IBAction func closeVideo(_ sender: Any) {
        UIView.animate(withDuration: 0.3) {
            if self.webView.frame.height == 0 {
                UIView.animate(withDuration: 1, animations: {
                    self.webView.frame.size = CGSize(width: self.view.frame.width, height: 253)
                    self.sermonView.frame.origin.y = 368
                    self.sermonView.frame.size.height = self.view.frame.height
                    self.scrollView.frame.size.height = self.view.frame.height
                    self.tableView.frame.size.height = self.view.frame.height
                    
                }) { (_) in
                    self.webView.translatesAutoresizingMaskIntoConstraints = false
                    self.sermonView.translatesAutoresizingMaskIntoConstraints = false
                    self.scrollView.translatesAutoresizingMaskIntoConstraints = false
                    self.tableView.translatesAutoresizingMaskIntoConstraints = false
                    
                }
                
            }else {
                self.webView.translatesAutoresizingMaskIntoConstraints = true
                self.sermonView.translatesAutoresizingMaskIntoConstraints = true
                self.scrollView.translatesAutoresizingMaskIntoConstraints = true
                
                self.webView.frame.size = CGSize(width: self.view.frame.width, height: 0)
                self.searchDevice()
                self.sermonView.frame.size.height = self.view.frame.height
                self.scrollView.frame.size.height = self.view.frame.height
                
                self.tableView.topAnchor.constraint(equalTo: self.sermonView.topAnchor, constant: 50).isActive = true
                self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
                self.tableView.leadingAnchor.constraint(equalTo: self.sermonView.leadingAnchor).isActive = true
                self.tableView.trailingAnchor.constraint(equalTo: self.sermonView.trailingAnchor).isActive = true
            }
        }
    }
    
    func searchDevice() {
        if UIDevice().userInterfaceIdiom == .phone {
          switch UIScreen.main.nativeBounds.height {
            case 1136:
            print("iPhone se")
            self.sermonView.frame.origin.y = 80
            case 1334:
            print("iPhone 6/6S/7/8")
            self.sermonView.frame.origin.y = 80
            case 2208:
            print("iPhone 6+/6S+/7+/8+")
            self.sermonView.frame.origin.y = 80
            case 2436:
            print("iPhone X")
            self.sermonView.frame.origin.y = 112
            case 2688:
            print("iPhone 11pro Max")
            self.sermonView.frame.origin.y = 112
            case 1792:
            print("iPhone 11/Xr")
            self.sermonView.frame.origin.y = 112
            default:
            print("unknown")
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
        self.scrollView = UIScrollView(frame: CGRect(x: 0, y: 50, width: self.view.frame.width, height: self.view.frame.height))
        sermonView.addSubview(scrollView)
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.delegate = self
        self.scrollView.contentSize.width = self.view.frame.width*2
        
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.topAnchor.constraint(equalTo: sermonView.topAnchor, constant: 50).isActive = true
        self.scrollView.bottomAnchor.constraint(equalTo: sermonView.bottomAnchor).isActive = true
        self.scrollView.leadingAnchor.constraint(equalTo: sermonView.leadingAnchor).isActive = true
        self.scrollView.trailingAnchor.constraint(equalTo: sermonView.trailingAnchor).isActive = true
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x == 0 {
            self.segment.selectedSegmentIndex = 0
            tableView.alpha = 1
        }else if scrollView.contentOffset.x == self.view.frame.width {
            self.segment.selectedSegmentIndex = 1
            tableView.alpha = 0
        }
    }
}

//MARK:- TableView Delegate & DataSource

extension SermonViewController : UITableViewDelegate, UITableViewDataSource {
    
    func createTable() {
        self.tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        
        let view = UIView(frame: CGRect(x: self.view.frame.width, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        view.backgroundColor = .clear
        
        let tableNib = UINib(nibName: "SermonTableViewCell", bundle: nil)
        self.tableView.register(tableNib, forCellReuseIdentifier: "SermonCell")
        self.scrollView.addSubview(tableView)
        self.scrollView.addSubview(view)
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.topAnchor.constraint(equalTo: self.sermonView.topAnchor, constant: 50).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.sermonView.bottomAnchor).isActive = true
        self.tableView.leadingAnchor.constraint(equalTo: self.sermonView.leadingAnchor).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.sermonView.trailingAnchor).isActive = true
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "SermonCell", for: indexPath) as! SermonTableViewCell
        
        cell.title.text = "1. text text text"
        cell.sermonText.text = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia "
        cell.sermonText.isEditable = false
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(200)
    }
}

//MARK:-SequenceView

extension SermonViewController {
    
    func createSequence() {
        let sermonSequenceView = SermonSequenceView(frame: CGRect(x: self.view.frame.width, y: 0, width: self.view.frame.width, height: self.view.frame.height+100))
        sermonSequenceView.tag = 100
        scrollView.addSubview(sermonSequenceView)
    }
}
