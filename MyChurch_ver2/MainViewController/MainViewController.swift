//
//  MainViewControllerSub.swift
//  MyChurch_ver2
//
//  Created by 백승화 on 2020/07/30.
//  Copyright © 2020 백승화. All rights reserved.
//

import UIKit

import UIKit

class MainViewController : UIViewController {
    
    @UserAutoLayout
    var dateLabel = UILabel()
    
    @UserAutoLayout
    var kindLabel = UILabel()
    
    @UserAutoLayout
    var logoButton = UIButton()
    
    @UserAutoLayout
    var sermonView = UIView()
    var sermonTap : UIGestureRecognizer!
    
    @UserAutoLayout
    var newsView = UIView()
    var newsTap : UIGestureRecognizer!
    
    @UserAutoLayout
    var columnView = UIView()
    var columnTap : UIGestureRecognizer!
    
    @UserAutoLayout
    var moreButton = UIButton()
    
    @UserAutoLayout
    var adView = UIView()
    
    @UserAutoLayout
    var rootStackView = UIStackView()
    
    var gestureToggle : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSuperView()
        setRootStackView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {return}
        if identifier == "Sermon" {
            let sc = segue.destination as! SermonViewController
            sc.kind = kindLabel.text
        }
    }
    
    func setUpNotification() {
        if #available(iOS 13.0, *) {
            NotificationCenter.default.addObserver(self, selector: #selector(foregroundNotification), name: UIScene.willEnterForegroundNotification, object: nil)
        }else{
            NotificationCenter.default.addObserver(self, selector: #selector(foregroundNotification), name: UIApplication.willEnterForegroundNotification, object: nil)
        }
    }
    
    @objc func foregroundNotification() {
        setUpDateKind()
        inputDay()
    }
    
    //MARK: - superView
    
    ///superView의 설정을 해주는 메서드
    func setSuperView() {
        let downGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.downGesture(gesture:)))
        downGesture.direction = .down
        let upGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.upGesture(gesture:)))
        upGesture.direction = .up
        
        self.view.addGestureRecognizer(downGesture)
        self.view.addGestureRecognizer(upGesture)
    }
    
    ///더보기 버튼 추가
    @objc func upGesture(gesture : UISwipeGestureRecognizer) {
        if gestureToggle {
            
            let addView = self.setMoreButton()
            self.rootStackView.addArrangedSubview(addView)
            
            UIView.animate(withDuration: 0.35) {
                addView.isHidden = false
            } completion: { [weak self] (_) in
                guard let self = self else {return}
                self.toggleGesture()
            }
        }
    }
    
    ///더보기 버튼 제거
    @objc func downGesture(gesture : UISwipeGestureRecognizer) {
        if !gestureToggle {
            UIView.animate(withDuration: 0.35) { [weak self] in
                guard let self = self else {return}
                self.moreButton.isHidden = true
            }
            self.moreButton.removeFromSuperview()
            self.toggleGesture()
        }
    }
    
    ///현재 스와이프 상태를 보고 바꿔주는 역할을 해주는 메서드
    func toggleGesture(){
        if gestureToggle {
            self.gestureToggle = false
        }else {
            self.gestureToggle = true
        }
    }
    
    ///광고 뷰를 만드는 메서드
    func setAdView() -> UIView {
        self.adView.backgroundColor = UIColor(named: "more")
        self.adView.layer.cornerRadius = 10
        self.adView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        return self.adView
    }
    
    ///더보기 버튼을 만드는 메서드
    func setMoreButton() -> UIView {
        self.moreButton.backgroundColor = UIColor(named: "more")
        self.moreButton.layer.cornerRadius = 10
        self.moreButton.isHidden = true
        self.moreButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        self.moreButton.setTitle("더 보기", for: .normal)
        self.moreButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        self.moreButton.titleLabel?.adjustsFontSizeToFitWidth = true
        self.moreButton.titleLabel?.adjustsFontForContentSizeCategory = true
        self.moreButton.setTitleColor(.black, for: .normal)
        self.moreButton.addTarget(self, action: #selector(self.touchMoreButton(sender:)), for: .touchUpInside)
        
        return self.moreButton
    }
    
    ///더보기 버튼 액션 부분
    @objc func touchMoreButton(sender : UIButton) {
        performSegue(withIdentifier: "More", sender: nil)
    }
    
    //MARK: - setRootView
    
    ///제일 상단의 stackView를 구성하는 메서드
    func setRootStackView() {
        self.rootStackView.alignment = .fill
        self.rootStackView.distribution = .fill
        self.rootStackView.axis = .vertical
        self.rootStackView.spacing = 15
        
        self.view.addSubview(self.rootStackView)
        let constraint = self.rootStackView.eachSafeAreaConstraintsForAnchorsTo(view : self.view, top: 30, leading: 10, bottom: 10, trailing: 10)
        NSLayoutConstraint.activate(constraint)
    
        let topView = setTopView()
        
        let adView = setAdView()
        adView.isHidden = false
        
        let mainView = setMainView()
        mainView.setContentCompressionResistancePriority(UILayoutPriority(749), for: .vertical)
        mainView.setContentHuggingPriority(UILayoutPriority(249), for: .vertical)
        
        self.rootStackView.addArrangedSubview(topView)
        self.rootStackView.addArrangedSubview(adView)
        self.rootStackView.addArrangedSubview(mainView)
    }
    
    //MARK: - setTopView
    
    ///상단의 예배의 종류와 날짜와 로고를 표시하는 뷰를 구성하는 메서드
    func setTopView() -> UIView {
        let topStackView = UIStackView()
        topStackView.alignment = .fill
        topStackView.distribution = .fill
        topStackView.axis = .horizontal
        topStackView.spacing = 8
        
        let titleKindLabelView = setTitleKindLabelView()
        titleKindLabelView.setContentHuggingPriority(UILayoutPriority(251), for: .vertical)
        titleKindLabelView.setContentHuggingPriority(UILayoutPriority(251), for: .horizontal)
        
        self.logoButton.setImage(UIImage(named: "church_logo"), for: .normal)
        self.logoButton.widthAnchor.constraint(equalToConstant: 52).isActive = true
        self.logoButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
        self.logoButton.setContentHuggingPriority(UILayoutPriority(48), for: .horizontal)
        self.logoButton.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh-1.0, for: .horizontal)
        self.logoButton.addTarget(self, action: #selector(self.touchLogoButton(sender:)), for: .touchUpInside)
        
        topStackView.addArrangedSubview(titleKindLabelView)
        topStackView.addArrangedSubview(self.logoButton)
        
        return topStackView
    }
    
    ///로고버튼의 액션을 취하는 메서드
    @objc func touchLogoButton(sender: UIButton) {
        performSegue(withIdentifier: "AllData", sender: nil)
    }
    
    ///setTopView메서드의 속해서 레이블을 구성하는 메서드
    func setTitleKindLabelView() -> UIView {
        let titleKindLabelStackView = UIStackView()
        titleKindLabelStackView.alignment = .leading
        titleKindLabelStackView.distribution = .fill
        titleKindLabelStackView.axis = .vertical
        titleKindLabelStackView.spacing = 8
        
        self.dateLabel.text = "7월 29일"
        self.dateLabel.textColor = .gray
        self.dateLabel.setContentCompressionResistancePriority(UILayoutPriority(749), for: .vertical)
        self.dateLabel.setContentHuggingPriority(UILayoutPriority(249), for: .vertical)
        self.dateLabel.font = UIFont.boldSystemFont(ofSize: 17)
        
        self.kindLabel.text = "오전2부 예배"
        self.kindLabel.font = UIFont.boldSystemFont(ofSize: 19)
        
        titleKindLabelStackView.addArrangedSubview(dateLabel)
        titleKindLabelStackView.addArrangedSubview(kindLabel)
        
        return titleKindLabelStackView
    }
    
    //MARK: - setMainView
    
    ///중간부분의 설교와 광고와 칼럼으로 이어지는 뷰를 구성하는 메서드
    func setMainView() -> UIView {
        let mainStackView = UIStackView()
        mainStackView.alignment = .fill
        mainStackView.distribution = .fill
        mainStackView.axis = .vertical
        mainStackView.spacing = 8
        
        self.sermonView.backgroundColor = UIColor(named: "moreButton")
        self.sermonView.layer.cornerRadius = 10
        self.sermonView.setContentHuggingPriority(UILayoutPriority(249), for: .vertical)
        self.sermonView.setContentCompressionResistancePriority(UILayoutPriority(749), for: .vertical)
        sermonTap = UITapGestureRecognizer(target: self, action: #selector(self.sermonAction(recognizer:)))
        sermonView.addGestureRecognizer(sermonTap)
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "church_white")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.sermonView.addSubview(imageView)
        let imageConstraints = imageView.fullConstraintsForAnchorsTo(view: self.sermonView)
        NSLayoutConstraint.activate(imageConstraints)
        
        let todaySermonLabel = UILabel()
        todaySermonLabel.text = "오늘의 설교"
        todaySermonLabel.font = UIFont.boldSystemFont(ofSize: 30)
        todaySermonLabel.translatesAutoresizingMaskIntoConstraints = false
        self.sermonView.addSubview(todaySermonLabel)
        todaySermonLabel.leadingAnchor.constraint(equalTo: self.sermonView.leadingAnchor, constant: 10).isActive = true
        todaySermonLabel.topAnchor.constraint(equalTo: self.sermonView.topAnchor, constant: 10).isActive = true
        
        let newsColumnView = setNewsColumnView()
        
        mainStackView.addArrangedSubview(self.sermonView)
        mainStackView.addArrangedSubview(newsColumnView)
        
        return mainStackView
    }
    
    ///setMainView에 속해서 소식과 칼럼뷰를 구성하는 메서드
    func setNewsColumnView() -> UIView {
        let newsColumnView = UIStackView()
        newsColumnView.alignment = .fill
        newsColumnView.distribution = .fill
        newsColumnView.axis = .horizontal
        newsColumnView.spacing = 8
        
        self.newsView.backgroundColor = UIColor(named: "more")
        self.newsView.layer.cornerRadius = 10
        newsTap = UITapGestureRecognizer(target: self, action: #selector(self.sermonAction(recognizer:)))
        newsView.addGestureRecognizer(newsTap)
        
        let newsLabel = UILabel()
        newsLabel.text = "소식"
        newsLabel.font = UIFont.boldSystemFont(ofSize: 25)
        newsLabel.translatesAutoresizingMaskIntoConstraints = false
        self.newsView.addSubview(newsLabel)
        newsLabel.leadingAnchor.constraint(equalTo: self.newsView.leadingAnchor, constant: 10).isActive = true
        newsLabel.topAnchor.constraint(equalTo: self.newsView.topAnchor, constant: 10).isActive = true
        
        self.columnView.backgroundColor = UIColor(named: "more")
        self.columnView.layer.cornerRadius = 10
        columnTap = UITapGestureRecognizer(target: self, action: #selector(self.sermonAction(recognizer:)))
        columnView.addGestureRecognizer(columnTap)
        
        let columnLabel = UILabel()
        columnLabel.text = "칼럼"
        columnLabel.font = UIFont.boldSystemFont(ofSize: 25)
        columnLabel.translatesAutoresizingMaskIntoConstraints = false
        self.columnView.addSubview(columnLabel)
        columnLabel.leadingAnchor.constraint(equalTo: self.columnView.leadingAnchor, constant: 10).isActive = true
        columnLabel.topAnchor.constraint(equalTo: self.columnView.topAnchor, constant: 10).isActive = true
        
        newsColumnView.addArrangedSubview(self.newsView)
        newsColumnView.addArrangedSubview(self.columnView)
    
        self.columnView.heightAnchor.constraint(equalToConstant: 122).isActive = true
        self.columnView.widthAnchor.constraint(equalToConstant: 122).isActive = true
        
        return newsColumnView
    }
    
    @objc func sermonAction(recognizer : UIGestureRecognizer) {
        switch recognizer {
        case sermonTap:
            performSegue(withIdentifier: "Sermon", sender: self)
            break
        case newsTap:
            performSegue(withIdentifier: "News", sender: self)
            break
        case columnTap:
            performSegue(withIdentifier: "Column", sender: self)
            break
        default:
            break
        }
    }
}


//MARK: -모델 부분이여서 나중에 별도로 만들 예정
extension MainViewController {
    func setUpDateKind() {
        let date = Date(timeIntervalSinceNow: 0)
        let calender = Calendar(identifier: .gregorian)
        let component = calender.dateComponents([.hour, .minute, .weekday], from: date)
        
        if let day = component.weekday {
            if day == 1 {
                if component.hour! >= 15 && component.hour! <= 17{
                    if component.minute! >= 30 {
                        kindLabel.text = "오후 예배"
                    }
                }else if component.hour! >= 11 && component.hour! <= 13{
                    kindLabel.text = "오전2부 예배"
                    
                }else if component.hour! >= 9 && component.hour! < 11 {
                    kindLabel.text = "오전1부 예배"
                    
                }
            }else if day == 4 {
                if component.hour! >= 20 && component.hour! <= 22 {
                    kindLabel.text = "수요예배"
                }
            }else if day == 6 {
                if component.hour! >= 20 && component.hour! <= 22 {
                    kindLabel.text = "금요예배"
                }
            }
        }
    }
    
    func inputDay() {
        let dateFormat = DateFormatter() // 출력할 데이트의 형식을 지정해주는 클래스
        let date = Date(timeIntervalSinceNow: 0) //데이트의 기준점
        dateFormat.locale = Locale(identifier: "ko_KR")
        dateFormat.timeStyle = DateFormatter.Style.none
        dateFormat.dateStyle = DateFormatter.Style.long
        dateFormat.setLocalizedDateFormatFromTemplate("MMMMd")
        dateLabel.text = dateFormat.string(from: date)
    }
}

