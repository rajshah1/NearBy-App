//
//  PlacesTabBar.swift
//  Near Me
//
//  Created by Raj Shah on 29/07/17.
//  Copyright © 2017 Raj Shah. All rights reserved.
//

import UIKit
import CoreLocation
class PlacesTabBar: UITabBarController {

    var placeType: String = String()
    var places: [Place] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additionl setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
