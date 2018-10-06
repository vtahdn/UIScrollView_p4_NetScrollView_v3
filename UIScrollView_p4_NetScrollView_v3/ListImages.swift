//
//  ListImages.swift
//  UIScrollView_p4_NetScrollView_v3
//
//  Created by macbook pro  on 9/1/18.
//  Copyright © 2018 Viet. All rights reserved.
//

import UIKit

class ListImages: UIViewController {
    
    // Go to a photo by a button's tag.
    @IBAction func buttonAction(sender: UIButton) {
        
        switch (sender.tag) {
            
            // Page 1
        case 101: push(0)
            
            // Page 2
        case 102: push(1)
            
            // Page 3
        case 103: push(2)
            
        default: break
            
        }
    }
    
    func push(index: Int) {
        
        // Initial a view by an ID
        let view = self.storyboard?.instantiateViewControllerWithIdentifier("ScrollView") as? ScrollView
        
        // Set a current page by an index
        view?.currentPage = index
        
        // Go to the view.
        self.navigationController?.pushViewController(view!, animated: true)
        
    }
    
}
