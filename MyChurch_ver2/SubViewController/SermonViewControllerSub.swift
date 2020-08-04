//
//  SermonViewControllerSub.swift
//  MyChurch_ver2
//
//  Created by 백승화 on 2020/08/04.
//  Copyright © 2020 백승화. All rights reserved.
//

import UIKit
import WebKit
import Firebase

class SermonViewControllerSub: UIViewController {
    
    @UserAutoLayout
    var superStackView = UIStackView()
    
    @UserAutoLayout
    var liveView = WKWebView()
    
    var topView = UIView()
    
    var sermonStackView = UIStackView()
    
    var sermonTableView = UITableView()
    
    var sequenceTableView = UITableView()
    
    var indicator : UIActivityIndicatorView!
    
    var titleLabel : UILabel!
    
    var docRef : DocumentReference!
    var kind : String?
    var sermonArr = [Dictionary<String, String>]()
    var sequenceArr = [Dictionary<String, String>]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setSuperView()
        makeFirestore()
    }
    
    ///setup SuperView UI
    func setSuperView() {
        self.view.backgroundColor = UIColor(named: "moreButton")
        self.setSuperStackView()
    }
    
    //MARK:- SuperStackView
    
    ///SuperStackView를 구성하는 메서드
    func setSuperStackView() {
        self.superStackView.axis = .vertical
        self.superStackView.distribution = .fill
        self.superStackView.alignment = .fill
        self.superStackView.spacing = 8
        
        self.view.addSubview(self.superStackView)
        self.superStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        self.superStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.view.trailingAnchor.constraint(equalTo: self.superStackView.trailingAnchor).isActive = true
        self.view.bottomAnchor.constraint(equalTo: self.superStackView.bottomAnchor).isActive = true
        
        let topView = setTopView()
        topView.setContentHuggingPriority(UILayoutPriority(251), for: .vertical)
        topView.setContentCompressionResistancePriority(UILayoutPriority(751), for: .vertical)
        
        self.liveView.navigationDelegate = self
        self.liveView.backgroundColor = .lightGray
        self.liveView.heightAnchor.constraint(equalTo: self.liveView.widthAnchor, multiplier: 0.56).isActive = true
        self.liveView.load(WebLiveGet.loadVideo(url: "https://www.youtube.com/embed/live_stream?channel=UC5PmuQM7rLMw5WwYDNCfWXw"))
        
        if #available(iOS 13, *) {
            self.indicator = UIActivityIndicatorView(style: .large)
            self.liveView.addSubview(indicator)
            indicator.translatesAutoresizingMaskIntoConstraints = false
            indicator.centerYAnchor.constraint(equalTo: self.liveView.centerYAnchor).isActive = true
            indicator.centerXAnchor.constraint(equalTo: self.liveView.centerXAnchor).isActive = true
        }else {
            self.indicator = UIActivityIndicatorView(style: .whiteLarge)
            self.liveView.addSubview(indicator)
            indicator.translatesAutoresizingMaskIntoConstraints = false
            indicator.centerYAnchor.constraint(equalTo: self.liveView.centerYAnchor).isActive = true
            indicator.centerXAnchor.constraint(equalTo: self.liveView.centerXAnchor).isActive = true
        }
        
        
        let sermonView = setSermonStackView()
        sermonView.setContentHuggingPriority(UILayoutPriority(249), for: .vertical)
        sermonView.setContentCompressionResistancePriority(UILayoutPriority(749), for: .vertical)
        
        self.superStackView.addArrangedSubview(topView)
        self.superStackView.addArrangedSubview(self.liveView)
        self.superStackView.addArrangedSubview(sermonView)
    }
    
    //MARK:- TopView
    
    ///제목과 종류가 들어가는 뷰를 구성하는 메서드
    func setTopView() -> UIView {
        let topView = UIStackView()
        topView.axis = .vertical
        topView.alignment = .fill
        topView.distribution = .fill
        topView.spacing = 1
        
        let spacingView2 = UIView()
        spacingView2.translatesAutoresizingMaskIntoConstraints = false
        spacingView2.widthAnchor.constraint(equalToConstant: 4).isActive = true
        
        let spaceView2 = UIStackView()
        spaceView2.axis = .horizontal
        spaceView2.distribution = .fill
        spaceView2.alignment = .fill
        
        let closeButton = setCloseButton()
        spaceView2.addArrangedSubview(closeButton)
        spaceView2.addArrangedSubview(spacingView2)
        
        let spacingView = UIView()
        spacingView.translatesAutoresizingMaskIntoConstraints = false
        spacingView.widthAnchor.constraint(equalToConstant: 4).isActive = true
        
        let spaceView = UIStackView()
        spaceView.axis = .horizontal
        spaceView.distribution = .fill
        spaceView.alignment = .fill
        
        let titleNKindView = setTitleNKindStackView()
        titleNKindView.translatesAutoresizingMaskIntoConstraints = false
        titleNKindView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        spaceView.addArrangedSubview(spacingView)
        spaceView.addArrangedSubview(titleNKindView)
        
        topView.addArrangedSubview(spaceView2)
        topView.addArrangedSubview(spaceView)
        
        return topView
    }
    
    ///closeButton에 스택뷰를 추가하고 구성하는 메서드
    func setCloseButton() -> UIView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .trailing
        stackView.distribution = .fill
        
        let button = CustomCloseButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 35).isActive = true
        button.widthAnchor.constraint(equalToConstant: 35).isActive = true
        button.addTarget(self, action: #selector(self.close(sender:)), for: .touchUpInside)
        
        stackView.addArrangedSubview(button)
        
        return stackView
    }
    
    @objc func close(sender : UIButton) {
        self.dismiss(animated: true)
    }
    
    ///title과 kind가 들어가는 view를 구성하는 메서드
    func setTitleNKindStackView() -> UIView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 5
        
        let kindLabel = UILabel()
        kindLabel.text = kind
        kindLabel.font = UIFont.boldSystemFont(ofSize: 15)
        kindLabel.setContentHuggingPriority(UILayoutPriority(249), for: .vertical)
        kindLabel.setContentCompressionResistancePriority(UILayoutPriority(749), for: .vertical)
        
        self.titleLabel = UILabel()
        titleLabel.text = "대흥교회 오전2부 예배 제목은 매우 길다"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.numberOfLines = 0
        
        stackView.addArrangedSubview(kindLabel)
        stackView.addArrangedSubview(titleLabel)
        
        
        return stackView
    }
    
    //MARK:- SermonStackView
    
    ///말씀 요약부분과 순서테이블과 segmentedController가 들어가는 뷰를 구성하는 메서드
    func setSermonStackView() -> UIView {
        self.sermonStackView.axis = .vertical
        self.sermonStackView.alignment = .fill
        self.sermonStackView.distribution = .fill
        self.sermonStackView.spacing = 5
        
        let controlView = setControlView()
        controlView.translatesAutoresizingMaskIntoConstraints = false
        controlView.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        let tableViews = UIView()
        tableViews.addSubview(self.sequenceTableView)
        tableViews.addSubview(self.sermonTableView)
        self.sequenceTableView.translatesAutoresizingMaskIntoConstraints = false
        let sequenceConstraints = self.sequenceTableView.fullConstraintsForAnchorsTo(view: tableViews)
        NSLayoutConstraint.activate(sequenceConstraints)
        
        self.sermonTableView.translatesAutoresizingMaskIntoConstraints = false
        let sermonConstraints = self.sermonTableView.fullConstraintsForAnchorsTo(view: tableViews)
        NSLayoutConstraint.activate(sermonConstraints)
        
        sermonStackView.addArrangedSubview(controlView)
        sermonStackView.addArrangedSubview(tableViews)
        
        return sermonStackView
    }
    
    ///segmentController와 WebViewClose버튼을 구성하는 메서드
    func setControlView() -> UIView {
        let containerView = UIView()

        let segmentedController = UISegmentedControl(items: ["텍스트 설교","예배 순서"])
        segmentedController.selectedSegmentIndex = 0
        segmentedController.addTarget(self, action: #selector(self.setSermonNSequenceView(sender:)), for: .valueChanged)
        if #available(iOS 13, *) {
        
        }else {
            let attributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
            segmentedController.setTitleTextAttributes(attributes, for: .normal)
            segmentedController.setTitleTextAttributes(attributes, for: .selected)
            segmentedController.backgroundColor = UIColor(white: 0.4, alpha: 0.3)
            segmentedController.tintColor = UIColor(white: 0.9, alpha: 0.6)
            segmentedController.layer.cornerRadius = 10
        }
        
        let webClolseButton = UIButton(type: .system)
        webClolseButton.setTitle("닫기", for: .normal)
        webClolseButton.setTitleColor(.black, for: .normal)
        webClolseButton.contentHorizontalAlignment = .trailing
        webClolseButton.addTarget(self, action: #selector(self.setWebButton(sender:)), for: .touchUpInside)
        
        containerView.addSubview(segmentedController)
        containerView.addSubview(webClolseButton)
        
        segmentedController.translatesAutoresizingMaskIntoConstraints = false
        segmentedController.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        webClolseButton.translatesAutoresizingMaskIntoConstraints = false
        containerView.trailingAnchor.constraint(equalTo: webClolseButton.trailingAnchor, constant: 4).isActive = true
        
        return containerView
    }
    
    ///webCloseButton의 액션 부분을 담당하는 메서드
    @objc func setWebButton(sender : UIButton) {
        if sender.titleLabel?.text == "닫기" {
            sender.setTitle("열기", for: .normal)
            
            UIView.animate(withDuration: 0.25, animations: {
                self.indicator.isHidden = true
                self.liveView.alpha = 0
                self.liveView.isHidden = true
            }) { [weak self] (_) in
                guard let self = self else {return}
                self.liveView.removeFromSuperview()
            }

        }
        else if sender.titleLabel?.text == "열기" {
            sender.setTitle("닫기", for: .normal)
            self.superStackView.insertArrangedSubview(self.liveView, at: 1)
            
            UIView.animate(withDuration: 0.25) { [weak self] in
                guard let self = self else {return}
                if self.liveView.isLoading == true {
                    self.indicator.isHidden = false
                }
                self.liveView.isHidden = false
                self.liveView.alpha = 1

            }
        }
    }
    
    ///segmentedController의 액션 부분을 담당하는 메서드
    @objc func setSermonNSequenceView(sender : UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            self.sequenceTableView.isHidden = true
            self.sermonTableView.isHidden = false
        }
        else if sender.selectedSegmentIndex == 1 {
            self.sermonTableView.isHidden = true
            self.sequenceTableView.isHidden = false
        }
    }
    
    ///tableView를 구성하는 메서드
    func setTableView() {
        let sermonNib = UINib(nibName: "SermonTableViewCell", bundle: nil)
        sermonTableView.register(sermonNib, forCellReuseIdentifier: "SermonCell")
        let sequenceNib = UINib(nibName: "SermonListTableView", bundle: nil)
        sequenceTableView.register(sequenceNib, forCellReuseIdentifier: "ListCell")

        self.sermonTableView.delegate = self
        self.sermonTableView.dataSource = self
        self.sequenceTableView.delegate = self
        self.sequenceTableView.dataSource = self
        
        self.sermonTableView.separatorStyle = .none
        self.sermonTableView.rowHeight = UITableView.automaticDimension
        self.sermonTableView.estimatedRowHeight = 600
        
        self.sequenceTableView.rowHeight = UITableView.automaticDimension
        self.sequenceTableView.estimatedRowHeight = 300
    }
}

//MARK:- TableView Protocol

extension SermonViewControllerSub : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.sermonTableView {
            return sermonArr.count
        }else {
            return sequenceArr.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == self.sermonTableView {
            let index = sermonArr[indexPath.row]
            let cell = self.sermonTableView.dequeueReusableCell(withIdentifier: "SermonCell", for: indexPath) as! SermonTableViewCell
            
            cell.title.text = index["subtitle"]?.replacingOccurrences(of: "\\n", with: "\n")
            cell.sermonText.text = index["content"]?.replacingOccurrences(of: "\\n", with: "\n")
            
            return cell
        }else {
            let index = sequenceArr[indexPath.row]
            
            let cell = self.sequenceTableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! SermonListTableView
            
            cell.title.text = index["title"]
            cell.content.text = index["content"]?.replacingOccurrences(of: "\\n", with: "\n")
            
            return cell
        }
    }
    
}

//MARK:- WebViewDelegate

extension SermonViewControllerSub : WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.indicator.stopAnimating()
        self.indicator.isHidden = true
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        self.indicator.startAnimating()
        self.indicator.isHidden = false
    }
}

//MARK:- FireStore

extension SermonViewControllerSub {
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
    }
    
    func getdata() {
        docRef.getDocument { [weak self](snapshot, error) in
            guard let _self = self else {return}
            if let error = error {
                print(error.localizedDescription)
            }else {
                guard let snapshot = snapshot, snapshot.exists else {print("there is no data");return}
                if let data = snapshot.data() {
                    _self.titleLabel.text = data["title"] as? String
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
                _self.sermonTableView.reloadData()
                _self.sequenceTableView.reloadData()
            }
        }
    }
}
