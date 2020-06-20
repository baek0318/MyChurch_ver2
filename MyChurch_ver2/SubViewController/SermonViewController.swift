//
//  SermonViewController.swift
//  MyChurch_ver2
//
//  Created by 백승화 on 2020/05/03.
//  Copyright © 2020 백승화. All rights reserved.
//

import UIKit
import WebKit
import FirebaseFirestore

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
    var listTableView : UITableView!
    
    var docRef : DocumentReference!
    var kind : String?
    var sermonArr = [Dictionary<String, String>]()
    var sequenceArr = [Dictionary<String, String>]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeFirestore()
        loadVideo()
        loadScrollView()
        segment.addTarget(self, action: #selector(self.segmentedAction(_:)), for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        sermonKind.text = kind
    }
    
    override func viewDidAppear(_ animated: Bool) {
        createSequence()
        createTable()
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
                    self.webButton.setTitle("닫기", for: .normal)
                    if(self.webView.isLoading) {
                        print(true)
                        self.webLoading.isHidden = false
                    }else{
                        print(false)
                        self.webLoading.isHidden = true
                    }
                    self.webView.frame.size = CGSize(width: self.view.frame.width, height: 253)
                    self.sermonView.frame.origin.y = 368
                    self.sermonView.frame.size.height = self.view.frame.height
                    self.scrollView.frame.size.height = self.view.frame.height
                    self.tableView.frame.size.height = self.view.frame.height
                    self.listTableView.frame.size.height = self.view.frame.height
                    
                }) { (_) in
                    self.webView.translatesAutoresizingMaskIntoConstraints = false
                    self.sermonView.translatesAutoresizingMaskIntoConstraints = false
                    self.scrollView.translatesAutoresizingMaskIntoConstraints = false
                    self.tableView.translatesAutoresizingMaskIntoConstraints = false
                    self.listTableView.translatesAutoresizingMaskIntoConstraints = false
                    
                }
                
            }else {
                self.webButton.setTitle("열기", for: .normal)
                self.webView.translatesAutoresizingMaskIntoConstraints = true
                self.sermonView.translatesAutoresizingMaskIntoConstraints = true
                self.scrollView.translatesAutoresizingMaskIntoConstraints = true
                
                self.webView.frame.size = CGSize(width: self.view.frame.width, height: 0)
                self.searchDevice()
                self.sermonView.frame.size.height = self.view.frame.height
                self.scrollView.frame.size.height = self.view.frame.height
                self.webLoading.isHidden = true
                
                self.tableView.topAnchor.constraint(equalTo: self.sermonView.topAnchor, constant: 50).isActive = true
                self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
                self.tableView.leadingAnchor.constraint(equalTo: self.sermonView.leadingAnchor).isActive = true
                self.tableView.trailingAnchor.constraint(equalTo: self.sermonView.trailingAnchor).isActive = true
                
                self.listTableView.topAnchor.constraint(equalTo: self.sermonView.topAnchor, constant: 50).isActive = true
                self.listTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
                self.listTableView.leadingAnchor.constraint(equalTo: self.sermonView.leadingAnchor).isActive = true
                self.listTableView.trailingAnchor.constraint(equalTo: self.sermonView.trailingAnchor).isActive = true
            }
        }
    }
    
    func searchDevice() {
        if UIDevice().userInterfaceIdiom == .phone {
          switch UIScreen.main.nativeBounds.height {
            case 1136:
            //"iPhone se"
            self.sermonView.frame.origin.y = 95
            case 1334:
            //"iPhone 6/6S/7/8"
            self.sermonView.frame.origin.y = 95
            case 2208:
            //"iPhone 6+/6S+/7+/8+"
            self.sermonView.frame.origin.y = 95
            case 2436:
            //"iPhone X"
            self.sermonView.frame.origin.y = 117
            case 2688:
            //"iPhone 11pro Max"
            self.sermonView.frame.origin.y = 117
            case 1792:
            //"iPhone 11/Xr"
            self.sermonView.frame.origin.y = 117
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
        webLoading.isHidden = false
        webLoading.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
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
        if scrollView == self.scrollView && scrollView.contentOffset.x == 0 {
            self.segment.selectedSegmentIndex = 0
            tableView.alpha = 1
        }else if scrollView == self.scrollView && scrollView.contentOffset.x == self.view.frame.width {
            self.segment.selectedSegmentIndex = 1
            tableView.alpha = 0
        }
    }
}

//MARK:- TableView Delegate & DataSource

extension SermonViewController : UITableViewDelegate, UITableViewDataSource {
    
    func createTable() {
        self.tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        
        let tableNib = UINib(nibName: "SermonTableViewCell", bundle: nil)
        self.tableView.register(tableNib, forCellReuseIdentifier: "SermonCell")
        self.scrollView.addSubview(tableView)
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.topAnchor.constraint(equalTo: self.sermonView.topAnchor, constant: 50).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.sermonView.bottomAnchor).isActive = true
        self.tableView.leadingAnchor.constraint(equalTo: self.sermonView.leadingAnchor).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.sermonView.trailingAnchor).isActive = true
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 600
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tableView {
            return sermonArr.count
        }else {
            return sequenceArr.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == self.tableView {
            let index = sermonArr[indexPath.row]
            
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "SermonCell", for: indexPath) as! SermonTableViewCell
            
            cell.title.text = index["subtitle"]?.replacingOccurrences(of: "\\n", with: "\n")
            cell.sermonText.text = index["content"]?.replacingOccurrences(of: "\\n", with: "\n")
            
            return cell
        }else {
            let index = sequenceArr[indexPath.row]
            
            let cell = self.listTableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! SermonListTableView
            
            
            cell.title.text = index["title"]
            cell.content.text = index["content"]?.replacingOccurrences(of: "\\n", with: "\n")
            
            return cell
        }
    }
    
}

//MARK:-SequenceView

extension SermonViewController {
    
    func createSequence() {
        self.listTableView = UITableView(frame: CGRect(x: self.view.frame.width, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        
        let tableNib = UINib(nibName: "SermonListTableView", bundle: nil)
        self.listTableView.register(tableNib, forCellReuseIdentifier: "ListCell")
        self.scrollView.addSubview(listTableView)
        
        self.listTableView.translatesAutoresizingMaskIntoConstraints = false
        self.listTableView.topAnchor.constraint(equalTo: self.sermonView.topAnchor, constant: 50).isActive = true
        self.listTableView.bottomAnchor.constraint(equalTo: self.sermonView.bottomAnchor).isActive = true
        self.listTableView.leadingAnchor.constraint(equalTo: self.sermonView.leadingAnchor).isActive = true
        self.listTableView.trailingAnchor.constraint(equalTo: self.sermonView.trailingAnchor).isActive = true
        
        self.listTableView.delegate = self
        self.listTableView.dataSource = self
        self.listTableView.separatorStyle = .none
        self.listTableView.rowHeight = UITableView.automaticDimension
        self.listTableView.estimatedRowHeight = 300
    }
}

//MARK:-Firestore Data Read

extension SermonViewController {
    func makeFirestore() {
        guard let kind = kind else {return}
        let date = Date(timeIntervalSinceNow: 0)
        let calendar = Calendar(identifier: .gregorian)
        let component = calendar.dateComponents([.month, .day], from: date)

        let date_path = "\(String(describing: component.month!))_\(String(describing: component.day!))"

        if kind == "오후 예배"{
            docRef = Firestore.firestore().document("sermon/\(date_path)/kind/evening")
        }else if kind == "오전1부 예배" || kind == "오전2부 예배"{
            docRef = Firestore.firestore().document("sermon/\(date_path)/kind/morning")
        }else if kind == "수요예배"{
            docRef = Firestore.firestore().document("sermon/\(date_path)/kind/wednesday")
        }else if kind == "금요예배"{
            docRef = Firestore.firestore().document("sermon/\(date_path)/kind/friday")
        }else {
            //아무것도 아닌경우 지정해주기
            docRef = Firestore.firestore().document("sermon/5_31/kind/morning")
        }
        getdata()
    }
    
    func getdata() {
        docRef.getDocument { [weak self](snapshot, error) in
            guard let _self = self else {return}
            if let error = error {
                print(error.localizedDescription)
            }else {
                guard let snapshot = snapshot, snapshot.exists else {print("there is no data");return}
                if let data = snapshot.data() {
                    _self.sermonTitle.text = data["title"] as? String
                    for i in 1..<data.count {
                        let num = data["\(i)"] as? Dictionary<String,String>
                        _self.sermonArr.append(num ?? ["" : ""])
                    }
                    let sequneceData = data["sequence"] as? Dictionary<String, Dictionary<String,String>>
                    guard let sequence = sequneceData else {return}
                    for i in 1...sequence.count {
                        guard let num = sequence["\(i)"] else {return}
                        _self.sequenceArr.append(num)
                    }
                }
            }
        }
    }
}
