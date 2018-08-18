    //
//  MyListtDetailViewController.swift
//  LL
//
//  Created by Maria Susana Moline Venanzi on 5/25/18.
//  Copyright © 2018 HRApps. All rights reserved.
//

import UIKit
import CoreData

class MyListtDetailViewController: UIViewController {

    
    //var lugarEditar : Lugares!
    
    
    @IBOutlet weak var nombreEd: UITextField!
    
    
    func conexion () -> NSManagedObjectContext {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return delegate.persistentContainer.viewContext
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //print("nombre ya aqui es :  \(lugarEditar.nombre!)")
        // Do any additional setup after loading the view.
        //nombreEd.text = lugarEditar.nombre
        
        
        
    }

    
    
    
    
//    
//    @IBAction func editButton(_ sender: UIButton) {
//        
//        let contexto = conexion()
//       
//        lugarEditar.setValue(nombreEd.text, forKey: "nombre")
//        
//        do {
//            try contexto.save()
//            
//            performSegue(withIdentifier: "enviarATabla", sender: self)
//            
//            
//            print("guardo")
//        } catch let error as NSError {
//            print("no guardo", error)
//        }
//        
//        
//        
//    }
//    
    }
