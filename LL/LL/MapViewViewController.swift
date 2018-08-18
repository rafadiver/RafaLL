//
//  MapViewViewController.swift
//  LL
//
//  Created by Maria Susana Moline Venanzi on 5/27/18.
//  Copyright © 2018 HRApps. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewViewController: UIViewController {

    var name : String = ""
    var address : String = ""
    var category : String = ""
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("ya estoy en el mapa \(name)")
        
        let geocoder = CLGeocoder()
        self.mapView.delegate = self
        
        
        geocoder.geocodeAddressString(self.address) { (placemarks, error) in
            
            if error == nil {
                // procesar los posibles lugares
            
                for placemark in placemarks! {
                    print(placemark)
                    
                    let annotation = MKPointAnnotation()
                    annotation.title = self.name
                    annotation.coordinate = (placemark.location?.coordinate)!
                    annotation.subtitle = self.category
                    
                self.mapView.showAnnotations([annotation], animated: true)
                    
                self.mapView.selectAnnotation(annotation, animated: true)
                    
                    
                }
            
            
            } else {
                print("ha sucedido un error \(String(describing: error?.localizedDescription))")
            }
            
        }
        
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



extension MapViewViewController : MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let identifier = "MyPin"
        
        if annotation.isKind(of: MKUserLocation.self) {
            return nil
        }
        
        var annotationView : MKPinAnnotationView? = self.mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        }
        
        return annotationView
        
    }
    
    
}

