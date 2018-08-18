//
//
//  SurroundingsViewController.swift
//  Here1.7
//
//  Created by Maria Susana Moline Venanzi on 3/11/18.
//  Copyright © 2018 HRApps. All rights reserved.
//

import UIKit

class SurroundingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    var places : [Place] = []
    //var ids : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = false
        tableView.delegate = self
        tableView.dataSource = self
        
        
        //let tabbar = tabBarController as! TabBarController
    
        
   
    }
    
    override func viewWillAppear(_ animated: Bool) {

        let tabbar = tabBarController as! TabBarController
        places = tabbar.places
        //print(places.count)
        tableView.reloadData()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let celID = "LugarCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: celID, for: indexPath) as! LugarCell
        
        cell.nameLabel.text = places[indexPath.row].name
        cell.categoryLabel.text = places[indexPath.row].categoryShortName
        cell.cityLabel.text = places[indexPath.row].city
        cell.thumbnailImageView.image = #imageLiteral(resourceName: "placeholder-image")
        cell.distantLabel.text = ("Distance : \(String(describing: places[indexPath.row].distance!)) metros")
        
        
        DispatchQueue.global().async {
            if self.places[indexPath.row].icon != nil {
                if let url = URL(string: self.places[indexPath.row].icon!){
                    if let data = NSData(contentsOf: url)
                    {
                        DispatchQueue.main.async{
                        cell.thumbnailImageView.image = UIImage(data: data as Data)
                        } // DispatchQueue
                    } // if let data
                } // if url = URL
            } // icon != nil
        } // Dispatch Global
        
        
        
    
        return cell
        
    } // cellForRowAt
    
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(indexPath.row)
       
    }
    

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {

    
    if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let id = self.places[indexPath.row].id
                let guest = segue.destination as! DetailPlaceTableViewController
                guest.id = id!
            } // if let indexPath
    } // if segue.identifier ==
        
        
    } // prepare(for segue:
} // CLASS  SurroundingsViewController

