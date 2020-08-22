//
//  ExAdMainViewController.swift
//  MyChurch_ver2
//
//  Created by 백승화 on 2020/08/21.
//  Copyright © 2020 백승화. All rights reserved.
//

import UIKit

extension MainViewController : UIPageViewControllerDataSource, UIPageViewControllerDelegate{
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            if let currentViewController = pageVC.viewControllers?[0] as? AdContentViewController {
                self.currentIdx = currentViewController.idx
            }
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let vc = viewController as! AdContentViewController
        var index = vc.idx
                
        if(index == NSNotFound) {
            
            return nil
        }
        if index == 0 {
            index = pageAds.count-1
        }else {
            index! -= 1
        }
        return self.setViewControllers(index: index!)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let vc = viewController as! AdContentViewController
        var index = vc.idx
                
        if(index == NSNotFound) {
            return nil
        }
        
        if index == pageAds.count-1 {
            index = 0
        }else {
            index! += 1
        }
        
        return self.setViewControllers(index: index!)
    }
}
