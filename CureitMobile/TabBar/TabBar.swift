//
//  TabBar.swift
//  CureitMobile
//
//  Created by mac on 20/03/25.
//

import Foundation
import UIKit

class TabBar: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    func setupTabBar() {
            let homeVC1 = UIStoryboard(name: "HomeVC", bundle: nil).instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        homeVC1.comingFrom = .incoming

            let homeVC2 = UIStoryboard(name: "HomeVC", bundle: nil).instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        homeVC2.comingFrom = .settled

            let homeVC3 = UIStoryboard(name: "HomeVC", bundle: nil).instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        homeVC3.comingFrom = .unsettled
            
            homeVC1.tabBarItem = UITabBarItem(title: "Incoming", image: UIImage(named: "incoming"), selectedImage: UIImage(named: "incoming"))
            homeVC2.tabBarItem = UITabBarItem(title: "Settled", image: UIImage(named: "settled"), selectedImage: UIImage(named: "settled"))
            homeVC3.tabBarItem = UITabBarItem(title: "Unsettled", image: UIImage(named: "unsettled"), selectedImage: UIImage(named: "unsettled"))

            // Adding view controllers to tab bar
            self.viewControllers = [homeVC1, homeVC2, homeVC3]

            // Tab bar appearance customization
            if let tabBar = self.tabBar as? UITabBar {
                tabBar.layer.shadowColor = UIColor.black.cgColor
                tabBar.layer.shadowOpacity = 0.2
                tabBar.layer.shadowOffset = CGSize(width: 0, height: -3)
                tabBar.layer.shadowRadius = 5
                tabBar.layer.masksToBounds = false
                tabBar.backgroundColor = .white
                tabBar.layer.cornerRadius = 4
            }
            
            UITabBar.appearance().tintColor = UIColor(hexString: "#13B8A7")
            UITabBar.appearance().unselectedItemTintColor = UIColor.lightGray

            let attributesNormal = [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
            let attributesSelected = [NSAttributedString.Key.foregroundColor: UIColor(hexString: "#13B8A7")]

            UITabBarItem.appearance().setTitleTextAttributes(attributesNormal, for: .normal)
            UITabBarItem.appearance().setTitleTextAttributes(attributesSelected, for: .selected)
        }}
