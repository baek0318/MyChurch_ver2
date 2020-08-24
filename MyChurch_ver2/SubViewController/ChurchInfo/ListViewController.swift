//
//  ListViewController.swift
//  MyChurch_ver2
//
//  Created by 백승화 on 2020/06/04.
//  Copyright © 2020 백승화. All rights reserved.
//

import UIKit
import Firebase

class ListViewController : UIViewController {
    
    @IBOutlet var titleName: UILabel!
    
    @IBOutlet weak var listTableView: UITableView!
    
    var saveTitle : String?
    
    private var morningData = [Dictionary<String, String>]()
    private var eveningData = [Dictionary<String, String>]()
    private var wednesdayData = [Dictionary<String, String>]()
    private var dawnData = [Dictionary<String, String>]()
    private var driveCourseData = [[Dictionary<String, String>]]()
    
    private var choiData = [Dictionary<String, String>]()
    private var dongData = [Dictionary<String, String>]()
    private var duData = [Dictionary<String, String>]()
    private var limData = [Dictionary<String, String>]()
    private var sungData = [Dictionary<String, String>]()
    private var paulData = [Dictionary<String, String>]()
    private var timothyData = [Dictionary<String, String>]()
    private var gatheringData = [[Dictionary<String, String>]]()
    
    private var churchData = [Dictionary<String, String>]()
    private var missionaryData = [Dictionary<String, String>]()
    private var missionData = [[Dictionary<String, String>]]()

    override func viewDidLoad() {
        self.titleName.text = saveTitle
        super.viewDidLoad()
        getDriveCourseData()
        getGatheringData()
        getMissionData()
        setListTableView()
    }
    
    func setListTableView() {
        listTableView.delegate = self
        listTableView.dataSource = self
    }
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

//MARK:- TableView Delegate Data

extension ListViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch saveTitle {
        case "차량운행":
            switch section {
            case 0:
                return "주일 오전 운행"
            case 1:
                return "주일 오후 운행"
            case 2:
                return "수요 운행"
            case 3:
                return "새벽 운행"
            default:
                return "default"
            }
        case "목장안내":
            switch section {
            case 0:
                return "성낙율 초원"
            case 1:
                return "이동하 초원"
            case 2:
                return "임흥식 초원"
            case 3:
                return "이두우 초원"
            case 4:
                return "최무근 초원"
            case 5:
                return "바울 셀"
            case 6:
                return "디모데 셀"
            default:
                return "default"
            }
        case "선교현황":
            switch section {
            case 0:
                return "교회 및 단체"
            case 1:
                return "협력 선교사"
            default:
                return "default"
            }
        default:
            return ""
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        switch saveTitle {
        case "차량운행":
            return 4
        case "목장안내":
            return 7
        case "선교현황":
            return 2
        default:
            return 1
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if saveTitle == "차량운행" {
           
            switch section {
            case 0:
                if driveCourseData.count == 4 {
                    return driveCourseData[0].count
                }
                else {
                    return 0
                }
            case 1:
                if driveCourseData.count == 4 {
                    return driveCourseData[1].count
                }
                else {
                    return 0
                }
            case 2:
                if driveCourseData.count == 4 {
                    return driveCourseData[2].count
                }
                else {
                    return 0
                }
            case 3:
                if driveCourseData.count == 4 {
                    return driveCourseData[3].count
                }
                else {
                    return 0
                }
            default:
                return 0
            }
        }
        else if saveTitle == "선교현황" {
            switch section {
            case 0:
                if missionData.count == 2 {
                    return missionData[0].count
                }
                else {
                    return 0
                }
            case 1:
                if missionData.count == 2 {
                    return missionData[1].count
                }
                else {
                    return 0
                }
            default:
                return 0
            }
        }
        else {
            switch section {
            case 0:
                if gatheringData.count == 7 {
                    return gatheringData[0].count
                }
                else {
                    return 0
                }
            case 1:
                if gatheringData.count == 7 {
                    return gatheringData[1].count
                }
                else {
                    return 0
                }
            case 2:
                if gatheringData.count == 7 {
                    return gatheringData[2].count
                }
                else {
                    return 0
                }
            case 3:
                if gatheringData.count == 7 {
                    return gatheringData[3].count
                }
                else {
                    return 0
                }
            case 4:
                if gatheringData.count == 7 {
                    return gatheringData[4].count
                }
                else {
                    return 0
                }
            case 5:
                if gatheringData.count == 7 {
                    return gatheringData[5].count
                }
                else {
                    return 0
                }
            case 6:
                if gatheringData.count == 7 {
                    return gatheringData[6].count
                }
                else {
                    return 0
                }
            default:
                return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if saveTitle == "차량운행" {
            let data = driveCourseData[indexPath.section][indexPath.row]
            
            let cell = listTableView.dequeueReusableCell(withIdentifier: "Cell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
            cell.textLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
            cell.textLabel?.text = data["number"]
            
            cell.detailTextLabel?.font = UIFont.preferredFont(forTextStyle: .subheadline)
            cell.detailTextLabel?.text = data["person"]
            
            return cell
        }
        else if saveTitle == "선교현황" {
            let data = missionData[indexPath.section][indexPath.row]
            let cell = listTableView.dequeueReusableCell(withIdentifier: "Cell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
            
            if data["name"] != nil {
                cell.textLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
                cell.textLabel?.text = data["name"]
            }
            else {
                cell.textLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
                cell.textLabel?.text = data["title"]
                
                cell.detailTextLabel?.font = UIFont.preferredFont(forTextStyle: .subheadline)
                cell.detailTextLabel?.text = data["subtitle"]
            }
            
            return cell
        }
        else  {
            let data = gatheringData[indexPath.section][indexPath.row]
            
            let cell = listTableView.dequeueReusableCell(withIdentifier: "Cell") ?? UITableViewCell(style: .default, reuseIdentifier: "Cell")
            
            cell.textLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
            cell.textLabel?.text = data["names"]
            
            return cell
        }
    }
}

//MARK:- getData From Firestore

extension ListViewController {
    func getDriveCourseData() {
        let db = Firestore.firestore()
        
        //주일 오전 운행 데이터를 가져오는 부분
        db.document("drive_course/morning").addSnapshotListener { [weak self] (snapshot, error) in
            guard let _self = self else {return}
            if let _error = error {
                fatalError(_error.localizedDescription)
            }else {
                guard let snapshot = snapshot, snapshot.exists else {print("there is no data");return}
                if let data = snapshot.data() as? Dictionary<String, Dictionary<String, String>> {
                    for i in 1...data.count {
                        if let newData = data["\(i)"] {
                            _self.morningData.append(newData)
                        }
                    }
                }
            }
            _self.driveCourseData.append(_self.morningData)
        }
        //주일 오후 운행 데이터를 가져오는 부분
        db.document("drive_course/evening").addSnapshotListener { [weak self] (snapshot, error) in
            guard let _self = self else {return}
            if let _error = error {
                fatalError(_error.localizedDescription)
            }else {
                guard let snapshot = snapshot, snapshot.exists else {print("there is no data");return}
                if let data = snapshot.data() as? Dictionary<String, Dictionary<String, String>> {
                    for i in 1...data.count {
                        if let newData = data["\(i)"] {
                            _self.eveningData.append(newData)
                        }
                    }
                }
            }
            _self.driveCourseData.append(_self.eveningData)
        }
        
        //수요 운행 데이터를 가져오는 부분
        db.document("drive_course/wednesday").addSnapshotListener { [weak self] (snapshot, error) in
            guard let _self = self else {return}
            if let _error = error {
                fatalError(_error.localizedDescription)
            }else {
                guard let snapshot = snapshot, snapshot.exists else {print("there is no data");return}
                if let data = snapshot.data() as? Dictionary<String, Dictionary<String, String>> {
                    for i in 1...data.count {
                        if let newData = data["\(i)"] {
                            _self.wednesdayData.append(newData)
                        }
                    }
                }
            }
            _self.driveCourseData.append(_self.wednesdayData)
        }
        
        //새벽 운행 데이터를 가져오는 부분
        db.document("drive_course/dawn").addSnapshotListener { [weak self] (snapshot, error) in
            guard let _self = self else {return}
            if let _error = error {
                fatalError(_error.localizedDescription)
            }else {
                guard let snapshot = snapshot, snapshot.exists else {print("there is no data");return}
                if let data = snapshot.data() as? Dictionary<String, Dictionary<String, String>> {
                    for i in 1...data.count {
                        if let newData = data["\(i)"] {
                            _self.dawnData.append(newData)
                        }
                    }
                }
            }
            _self.driveCourseData.append(_self.dawnData)
            _self.listTableView.reloadData()
        }
    }
    
    //목장 데이터를 불러오는 부분
    func getGatheringData() {
        let db = Firestore.firestore()
        let titleRow = ["sung", "dong", "lim", "du", "choi", "paul", "timothy"]
        
        for title in 0...titleRow.count-1 {
            db.document("gathering/\(titleRow[title])").addSnapshotListener { [weak self] (snapshot, error) in
                guard let _self = self else {return}
                if let _error = error {
                    fatalError(_error.localizedDescription)
                }else {
                    guard let snapshot = snapshot, snapshot.exists else {print("there is no data");return}
                    if let data = snapshot.data() as? Dictionary<String, Dictionary<String, String>> {
                        for i in 1...data.count {
                            if let newData = data["\(i)"] {
                                switch title {
                                case 0:
                                    _self.sungData.append(newData)
                                case 1:
                                    _self.dongData.append(newData)
                                case 2:
                                    _self.limData.append(newData)
                                case 3:
                                    _self.duData.append(newData)
                                case 4:
                                    _self.choiData.append(newData)
                                case 5:
                                    _self.paulData.append(newData)
                                case 6:
                                    _self.timothyData.append(newData)
                                default:
                                    _self.sungData.append(newData)
                                }
                            }
                        }
                        switch title {
                        case 0:
                            _self.gatheringData.append(_self.sungData)
                        case 1:
                            _self.gatheringData.append(_self.dongData)
                        case 2:
                            _self.gatheringData.append(_self.limData)
                        case 3:
                            _self.gatheringData.append(_self.duData)
                        case 4:
                            _self.gatheringData.append(_self.choiData)
                        case 5:
                            _self.gatheringData.append(_self.paulData)
                        case 6:
                            _self.gatheringData.append(_self.timothyData)
                        default:
                            _self.gatheringData.append(_self.sungData)
                        }
                    }
                }
                if title == 6 {
                    _self.listTableView.reloadData()
                }
            }
        }
    }
    
    //선교현황 데이터 불러오는 부분
    func getMissionData() {
        let db = Firestore.firestore()
        
        db.document("mission/church").addSnapshotListener { [weak self] (snapshot, error) in
            guard let _self = self else {return}
            if let _error = error {
                fatalError(_error.localizedDescription)
            }else {
                guard let snapshot = snapshot, snapshot.exists else {print("there is no data");return}
                if let data = snapshot.data() as? Dictionary<String, Dictionary<String, String>> {
                    for i in 1...data.count {
                        if let newData = data["\(i)"] {
                            _self.churchData.append(newData)
                        }
                    }
                }
            }
            _self.missionData.append(_self.churchData)
        }
        
        db.document("mission/missonary").addSnapshotListener { [weak self] (snapshot, error) in
            guard let _self = self else {return}
            if let _error = error {
                fatalError(_error.localizedDescription)
            }else {
                guard let snapshot = snapshot, snapshot.exists else {print("there is no data");return}
                if let data = snapshot.data() as? Dictionary<String, Dictionary<String, String>> {
                    for i in 1...data.count {
                        if let newData = data["\(i)"] {
                            _self.missionaryData.append(newData)
                        }
                    }
                }
            }
            _self.missionData.append(_self.missionaryData)
            _self.listTableView.reloadData()
        }
    }
}
