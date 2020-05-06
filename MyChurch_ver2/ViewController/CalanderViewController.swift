//
//  CalanderViewController.swift
//  MyChurch_ver2
//
//  Created by 백승화 on 2020/05/03.
//  Copyright © 2020 백승화. All rights reserved.
//

import UIKit

class CalanderViewController : UIViewController {
    
    @IBOutlet var calanderView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calanderView.delegate = self
        calanderView.dataSource = self
    }
}

//MARK:-Delegate & DataSource

extension CalanderViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 42
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = calanderView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        return cell
    }
    
}

//MARK:-CollectionViewLayout

extension CalanderViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width/8, height: self.view.frame.height/12)
    }
}
