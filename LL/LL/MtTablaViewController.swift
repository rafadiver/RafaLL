//
//  MtTablaViewController.swift
//  LL
//
//  Created by Maria Susana Moline Venanzi on 5/25/18.
//  Copyright © 2018 HRApps. All rights reserved.
//

import UIKit
import CoreData

class MtTablaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var MyTable: UITableView!
    
    var lugares : [Lugares] = []
    
    
    func conexion() -> NSManagedObjectContext {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return delegate.persistentContainer.viewContext
        
    }
    
    
    override func viewDidLoad() {
       
        
        super.viewDidLoad()

        MyTable.reloadData()
        MyTable.delegate = self
        MyTable.dataSource = self
        
        mostrarDatos()
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        MyTable.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        MyTable.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let contexto = conexion()
        let lugar = lugares[indexPath.row]
        
        if editingStyle == .delete {
            contexto.delete(lugar)
            
            
            do {
                try contexto.save()
            } catch let  error as NSError {
                print("No borro", error)
            }
            
            mostrarDatos()
            self.MyTable.deleteRows(at: [indexPath], with: .fade)
            //MyTable.reloadData()
            
        }
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        // Compartir
        let shareAction = UITableViewRowAction(style: .normal, title: "Share") { (action, indexpath) in
            
            let shareDefaultText = "Estoy irando este lugar \(String(describing: self.lugares[indexPath.row].nombre))"
            let activityController = UIActivityViewController(activityItems: [shareDefaultText], applicationActivities: nil)
            self.present(activityController,animated: true, completion: nil)
            }
        
        shareAction.backgroundColor = UIColor(displayP3Red: 30.0/255.0, green: 164.0/255.0, blue: 253.0/255.0, alpha: 1)
        
         //Borrar
        let deleteAction = UITableViewRowAction(style: .normal, title: "Borrar") { (action, indexpath) in
            
            
        self.lugares.remove(at: indexPath.row)

//            let contexto = self.conexion()
//            let lugar = self.lugares[indexPath.row]
//
//            contexto.delete(lugar)
//
//
//                do {
//                    try contexto.save()
//                } catch let  error as NSError {
//                    print("No borro", error)
//                }
//
                //mostrarDatos()
                
        self.MyTable.deleteRows(at: [indexPath], with: .fade)
          }
        deleteAction.backgroundColor = UIColor(displayP3Red: 202.0/255.0, green: 202.0/255.0, blue: 202.0/255.0, alpha: 1)
        
        
        
         return [shareAction, deleteAction]
        
        //return [shareAction]
    }
    
    
    
    // num num cell
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lugares.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = MyTable.dequeueReusableCell(withIdentifier: "CellRA" , for: indexPath)
        
        let lugar = lugares[indexPath.row]
        cell.textLabel?.text = lugar.nombre
        
        return cell
        
    }
    
    
    func mostrarDatos() {
        
        let contexto = conexion()
        let fetchRequest : NSFetchRequest<Lugares> = Lugares.fetchRequest()
        
        
        do {
            
            lugares = try contexto.fetch(fetchRequest)
        } catch let error as NSError {
            print("No mostro nada", error)
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "MyListSegue", sender: self)
        
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "MyListSegue" {
            
            if let id = MyTable.indexPathForSelectedRow {
                
                let fila  = lugares[id.row]
                let destino = segue.destination as! DetailPlaceMyListTableViewController
                destino.nameMylist = fila.nombre!
                
            }
            
        }
    
        
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
