//
//  MapViewViewController.swift
//  LL
//
//  Created by Maria Susana Moline Venanzi on 5/27/18.
//  Copyright © 2018 HRApps. All rights reserved.
//

import UIKit
import MapKit

class MapViewViewController: UIViewController {

    var name : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("ya estoy en el mapa \(name)")
        
        // Do any additional setup after loading the view.
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
