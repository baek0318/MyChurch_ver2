//
//  ListViewController.swift
//  MyChurch_ver2
//
//  Created by 백승화 on 2020/06/04.
//  Copyright © 2020 백승화. All rights reserved.
//

import UIKit

class ListViewController : UIViewController {
    
    @IBOutlet var titleName: UILabel!
    
    @IBOutlet weak var listTableView: UITableView!
    
    var saveTitle : String?
    
    override func viewDidLoad() {
        self.titleName.text = saveTitle
        super.viewDidLoad()
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
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = listTableView.dequeueReusableCell(withIdentifier: "Cell", for :indexPath)
        
        cell.textLabel?.text = "test"
        
        return cell
    }
    
    
}
