//
//  DetailPlace.swift
//  Arround
//
//  Created by Maria Susana Moline Venanzi on 4/18/18.
//  Copyright © 2018 HRApps. All rights reserved.


import Foundation
import UIKit
import CoreData

class DetailPlaceTableViewController: UITableViewController {

    var id : String = ""
    var place : Place!
    
    var name : String = " "
    var category : String = " "
    var bestPhoto : String?
    var address : String = " "
    var city : String = " "
    var state : String = " "
    var postalCode : String = " "
    var country : String = " "
    var phone : String = " "
    var url : String = " "

    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var bestPhotoImage: UIImageView!
    
    @IBOutlet weak var telefonoLabel: UILabel!
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBOutlet weak var website: UILabel!
    
    func conexion () -> NSManagedObjectContext {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return delegate.persistentContainer.viewContext
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    navigationController?.setNavigationBarHidden(false, animated: true)
        
        
        let baseURL2 = "https://api.foursquare.com/v2/venues/\(id)?&client_id=GNKCCW0LNIPQTHLOXSH5Z0FAOGS4NE32JFUCAL2ZKPSMFCNN&client_secret=GO5RRJF5J2SFMQCCH5HQWW3D5YPLCW4GKVHR3EPVZKK3BVSC&v=20180202"
        
        //https://api.foursquare.com/v2/venues/40bbc700f964a520b1001fe3?&client_id=GNKCCW0LNIPQTHLOXSH5Z0FAOGS4NE32JFUCAL2ZKPSMFCNN&client_secret=GO5RRJF5J2SFMQCCH5HQWW3D5YPLCW4GKVHR3EPVZKK3BVSC&v=20180202"
        if let finalURL2 = URL(string: baseURL2) {
            requestOnePlaceData(url: finalURL2)
        } else {
            print("malformed URL")
        }
        
    }
    
    
    override func viewDidLoad() {
    super.viewDidLoad()
       
        print(self.id)
    let baseURL2 = "https://api.foursquare.com/v2/venues/\(id)?&client_id=GNKCCW0LNIPQTHLOXSH5Z0FAOGS4NE32JFUCAL2ZKPSMFCNN&client_secret=GO5RRJF5J2SFMQCCH5HQWW3D5YPLCW4GKVHR3EPVZKK3BVSC&v=20180202"
    
        //4e53f95345ddffa8d194673a
        //40bbc700f964a520b1001fe3
    // https://api.foursquare.com/v2/venues/4df27ff4e4cda09e6d9fc15a?&client_id=GNKCCW0LNIPQTHLOXSH5Z0FAOGS4NE32JFUCAL2ZKPSMFCNN&client_secret=GO5RRJF5J2SFMQCCH5HQWW3D5YPLCW4GKVHR3EPVZKK3BVSC&v=20180502"
        if let finalURL2 = URL(string: baseURL2) {
        requestOnePlaceData(url: finalURL2)
        } else {
        print("malformed URL")
            print("here is the id")
            print(self.id)
        }
    }
    
    
    func requestOnePlaceData(url : URL) {
    
    let task = URLSession.shared.dataTask(with: url) {
            (data,response,error) in

            if let errorResponse = error {
                print(errorResponse)
         } else {
             
            
                guard let data = data else { return }
                
                do {
                    let placeData = try  JSONDecoder().decode(OnePlaceData.self, from: data)
                  
                
                    //print("heloo here")
                
                    //print(placeData.response.venue.name)
                    
            
                    var prefix : String?
                    
                    prefix = placeData.response.venue.bestPhoto?.prefix
                    
                    if let suffix =  placeData.response.venue.bestPhoto?.suffix {
                    
                    self.bestPhoto = "\(prefix!)300x300\(suffix)"
                        } else {
                        print("no suffix")
                        }
                    
                    
                   if let Haddress = placeData.response.venue.location.address {
                     self.address = Haddress
                    }
                    
                   
                    if let Hcity = placeData.response.venue.location.city   {
                        
                         self.city = Hcity
                    }
                    
                    
                    if let Hstate = placeData.response.venue.location.state {
                        self.state = Hstate
                    }
                    
                    if let Hzipcode = placeData.response.venue.location.postalCode {
                        self.postalCode = Hzipcode
                    }
                    
                    
                    if let Hcountry = placeData.response.venue.location.country {
                        self.country = Hcountry
                    }
                    //////// Mark
                    
                    if let telefono = placeData.response.venue.contact?.formattedPhone {
                    
                        self.phone = telefono
                    }
                    
                    if let url = placeData.response.venue.url {
                        
                        self.url = placeData.response.venue.url!
                        print(url)
                    }
                    
                    
                    var ix : Int?
                    
                    ix = placeData.response.venue.categories.count
                    
                    
                    
                    self.category = placeData.response.venue.categories[ix!-1].shortName!
                    
                    
                    
                    
                    //self.phone =  placeData.response.venue.contact.formattedPhone
                    
                    
                    //self.idTag.text = self.name
                    
                    
                   DispatchQueue.main.async {
                    // Correct
                    self.nameLabel.text = placeData.response.venue.name
                    self.name = placeData.response.venue.name
                    self.telefonoLabel.text = self.phone
                    //print(self.phone)
                    self.addressLabel.text = "\(self.address) \(self.city), \(self.state) \(self.postalCode)  \(self.country) "
                    self.website.text = placeData.response.venue.url
                    }// DispatchQueue
                    
                    DispatchQueue.main.async {
                       
                        if self.bestPhoto != nil {
                        
                        if let url = URL(string: self.bestPhoto!){
                            
                            if let data = NSData(contentsOf: url)
                            {
                                self.bestPhotoImage.image = UIImage(data: data as Data)
                                
                            } else {
                                self.bestPhotoImage.image = #imageLiteral(resourceName: "PlayaPhoto")
                                
                            }
                        }
                        }

                    } // Dispatch queu Photo
                    
                    
                    //self.NoOfVenuesFound = placeData.response.venues.count
                    
                    //if self.NoOfVenuesFound == 0 {
                    
                    //} else {
                    
                    //self.nameVC = placeData.response.venues[0].name
                    //print(self.nameVC)
                    //print(placeData.response.venues.count)
                    //self.NoOfVenuesFound = placeData.response.venues.count
                    
                    //let counter = placeData.response.venues.count
                    
                    //for i in 0...counter - 1 {
                    //  let place = placeData.response.venues[i].name
                    
                    
                    
                    // self.names.append(place)
                    
                    
                    // let id = placeData.response.venues[i].id
                    //  self.ids.append(id)
                    
                    // if placeData.response.venues[i].categories.count == 0 {
                    //     self.categoryShortName.append("Sin Categoria")
                    //} else {
                    
                    //   let categories = placeData.response.venues[i].categories[0].shortName
                    
                    //self.categoryShortName.append(categories!)
                    
                    //let icon = placeData.response.venues[i].categories[0].icon.prefix
                    //print(icon)
                    
                    
                    //print("\(icon)bg_64.png")
                    
                    
                    //self.icons.append("\(icon)bg_64.png")
                    
                    //}
                    
                    //}
                    
                    
                 
                } catch {
                    
                    print(error)
                    print(self.id)
                } // catch
            } //if error , else
        } // task = URL Sessiom
        task.resume()
    
 
    } // func requestOnePlaceData

    
//    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        
        if segue.identifier == "showMap" {
            let destinationVC = segue.destination as! MapViewViewController
//
            destinationVC.name = self.name
            destinationVC.address = self.address
            destinationVC.category = self.category
            
////            destinationVC.adress = self.addressF
////            destinationVC.tipo = self.tipodelugar
////            destinationVC.image = self.imageLugar.image
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
//
        case 3:
           self.performSegue(withIdentifier: "showMap", sender: nil)
//
//
//        case 2:
//            self.performSegue(withIdentifier: "showMap", sender: nil)
//
//
        default:
           break
        }
        
        
    }
    
    
 
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        
        let contexto = conexion()
        let entidadLugar = NSEntityDescription.entity(forEntityName: "Lugares", in: contexto)
        let newLugar = NSManagedObject(entity: entidadLugar!, insertInto: contexto)
        
        newLugar.setValue(nameLabel.text, forKey: "nombre")
        
        do {
            try contexto.save()
            print("guardo")
        } catch let error as NSError {
            print("no guardo", error)
        }
        
    }
    
    
    @IBAction func mostrar(_ sender: UIButton) {
        
        let contexto = conexion()
        let fetchRequest : NSFetchRequest<Lugares> = Lugares.fetchRequest()
        
        do {
            let resultados = try contexto.fetch(fetchRequest)
            print("numero de registros= \(resultados.count)")
            
            for res in resultados as [NSManagedObject] {
                let nombreLugar = res.value(forKey: "nombre")
                print(nombreLugar!)
                
            }
            
        } catch let error as NSError {
            print("no mostro nada", error)
        }
    }
    
    
    @IBAction func borrar(_ sender: UIBarButtonItem) {
    
        print("en el boton de borrar")
        let contexto = conexion()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Lugares")
        let borrarr = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
           try contexto.execute(borrarr)
            print("borro los datos")
            
        } catch let error as NSError {
            print("no mostro nada", error)
        }
    }
    
    

//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        switch indexPath.row {
//        case 3:
//            // hemos seleccionado la geolocolizacion
//            self.performSegue(withIdentifier: "showMap", sender: nil)
//        default:
//            break
//
//        }
//   }

  
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        <#code#>
//    }


}
