//  ViewController.swift
//  Created by Maria Susana Moline Venanzi on 4/25/18.
//  Copyright © 2018 HRApps. All rights reserved.


import UIKit
import CoreLocation
import CoreData

    
class ViewController: UIViewController, CLLocationManagerDelegate {
        
        var PlacesDataHandler : PlacesDataHandler!
        var places : [Place] = []
        var clicks = 0
        var NoVenues = 0
        var name = ""
        
        var manager = CLLocationManager()
        var latitud : CLLocationDegrees!
        var longitud : CLLocationDegrees!
        
        @IBOutlet weak var PlaceLabel: UILabel!
        @IBOutlet weak var clickButton: UIButton!
    
    
        override var prefersStatusBarHidden: Bool {
            return true
        }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.places = []; navigationController?.setNavigationBarHidden(true, animated: true)
        clicks = 0
    }
        
        override func viewDidLoad() {
            super.viewDidLoad()
        
            
            manager.delegate = self
            manager.requestWhenInUseAuthorization()
            manager.desiredAccuracy = kCLLocationAccuracyBest
            manager.startUpdatingLocation()
            
            
            let tabbar = tabBarController as! TabBarController
            PlaceLabel.text = String(tabbar.BarName)
            
            
            
        } //
    
    override func viewWillDisappear(_ animated: Bool) {
        
        let tabbar = tabBarController as! TabBarController
        tabbar.places = places
        //print(places.count)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        PlaceLabel.text = "LifeLike"

    }
    
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            
        }
        
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            if let location = locations.first {
                self.latitud = location.coordinate.latitude
                self.longitud = location.coordinate.longitude
            }
        }
    
    
    
    
    
    
        @IBAction func SearchButton(_ sender: UIButton) {
            
            if latitud != nil {
              
                
                if clicks == 0 {
     
                
                    
                    let baseURL = "https://api.foursquare.com/v2/venues/search?client_id=GNKCCW0LNIPQTHLOXSH5Z0FAOGS4NE32JFUCAL2ZKPSMFCNN&client_secret=GO5RRJF5J2SFMQCCH5HQWW3D5YPLCW4GKVHR3EPVZKK3BVSC&v=20180405&ll=\(latitud!),\(longitud!)&limit=50&radius=500"
                    
                    if let finalURL = URL(string: baseURL) {
                     
                        requestPlaceData(url: finalURL)
                    
                    } else {
                        print("malformed URL")
                     
                    }
                    
              
                }
                
           
                
                if clicks > 0 {
                    
                
                    if self.NoVenues - 1 == self.clicks {
                        self.clicks = 1
                    } else {
                        
                        if self.places.count != 0 {
                        self.PlaceLabel.text = self.places[clicks].name
                        }
                    }
                }
               
           
                self.clicks = self.clicks + 1
                
            } else {
                self.PlaceLabel.text = "Red de Internet baja"
                clicks = 0
            
            } // if latitud != nil 
            
        } // SearchButton
        
        
        
        func requestPlaceData(url : URL) {
            
            let task = URLSession.shared.dataTask(with: url) {
                (data,response,error) in
                
             
                
                if let errorResponse = error {
                    print(errorResponse)
                } else {
                    
                    guard let data = data else {
                        return
                    }
                    
                    do {
                        
                        
                        let placeData = try JSONDecoder().decode(PlacesData.self, from: data)
                        
                        
                        
                        self.NoVenues = placeData.response.venues.count
                        
                        
                        for i in 0...self.NoVenues - 1 {
                            
                            let place = placeData.response.venues[i].name
                            self.name = placeData.response.venues[i].name
                            let id = placeData.response.venues[i].id
                            
                            var city = ""
                            if placeData.response.venues[i].location.city != nil {
                                
                                city = placeData.response.venues[i].location.city!
                            }
                            
                            var distance = ""
                            if placeData.response.venues[i].location.distance != nil {
                                distance = String(placeData.response.venues[i].location.distance!)
                                //print("distance")
                               // print(distance)
                            }
                            
                            var category = ""
                            var icon : String?
                            
                            
                            if placeData.response.venues[i].categories.count != 0 {
                                
                                category = placeData.response.venues[i].categories[0].shortName!
                                
                                if placeData.response.venues[i].categories[0].icon.prefix != nil {
                                    
                                    
                                    if let iconPrefix = placeData.response.venues[i].categories[0].icon.prefix {
                                        
                                        icon = "\(iconPrefix)bg_64.png"
                                    }
                                    
                                    if icon != nil {
                                        //print(icon!)
                                    }
                                    
                                }
                            }
                            
                            
                            let p = Place(name: place, categoryShortName: category, city: city, icon: icon, id: id, distance: distance )
                                
                                
                                
                                //Place(name: place, categoryShortName : category, city: city, icon: icon, id: id)
                            
                            self.places = self.places + [p]
                            
                        }
                    } catch let error {
                        print(error)
                    }
                    
                    let delay = DispatchTime.now() + 0.2
                    DispatchQueue.main.asyncAfter(deadline: delay, execute: {
                        
                        if self.places[0].id != nil {
                            
                            self.PlaceLabel.text = self.places[0].name
                        let tabbar = self.tabBarController as! TabBarController
                            tabbar.places = self.places
                            //print(self.places.count)
                            
                        
                        }
                    })
                }
            }
            task.resume()
        } // func requestPlaceData
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let guest = segue.destination as! SurroundingsViewController
        guest.places = places
    } // PREPARE FOR SEGUE
    
        
        
        
} // ViewController


