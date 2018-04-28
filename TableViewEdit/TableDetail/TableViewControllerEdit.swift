//
//  TableViewControllerEdit.swift
//  TableViewEdit
//
//  Created by KERCKWEB on 03/03/2018.
//  Copyright © 2018 KERCKWEB. All rights reserved.
// sauvegard 1

import UIKit
import CloudKit
import QuartzCore



class TableViewControllerEdit: UIViewController, UITableViewDelegate,UITableViewDataSource {
  
    //  MARK: - Outlet
    @IBOutlet weak var tableviewEdit: UITableView!
    @IBOutlet weak var etditBouton: UIBarButtonItem!
     //  MARK: - Varriable
    var nomSection : [String] = ["Pièces Détachées","Filtres","Coirroies","Gaz"]
    var liste = [CKRecord]()
    var coirroies = [CKRecord]()
    var filtres = [CKRecord]()
    var gaz = [CKRecord]()
    var refresh: UIRefreshControl!
    var imageURL: URL!
    let documentsDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
    
    
    
    
    @objc func loadMaster () {
        
        loadData()
        //loadFiltres()
        loadGaz()
        loadCoirroies()
        
    }
    
   
 //  MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableviewEdit.dataSource = self
        tableviewEdit.delegate = self
        
        refresh = UIRefreshControl()
        refresh.attributedTitle = NSAttributedString(string: "Chargement Contrats")
        refresh.addTarget(self, action:#selector(TableViewControllerEdit.loadFiltres), for: .valueChanged)
        self.tableviewEdit.addSubview(refresh)
        
      
        loadMaster()
     
    }
    
//  MARK: - TABLEVIEW Animations
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        let transform = CATransform3DTranslate(CATransform3DIdentity, -250, 30, 0)
        cell.layer.transform = transform
        
        UIView.animate(withDuration: 0.5) {
            cell.alpha = 1
            cell.layer.transform = CATransform3DIdentity
        }
    }
    
    
 // MARK: - TABLE View Protocol
    
    
    func tableView (_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
        
    {
        
        print("la fonction est lancer ")
        
        
        if editingStyle == UITableViewCellEditingStyle.delete
        {
            let selectedRecordID = liste[(indexPath as NSIndexPath).row].recordID
            
            // print(selectedRecordID)
            
            let container = CKContainer.init(identifier: "iCloud.com.kerckweb.Swiffer")
            
            let privateDatabase = container.publicCloudDatabase
            
            privateDatabase.delete(withRecordID: selectedRecordID, completionHandler:
                { (recordID, error) -> Void in
                    if error != nil
                    {
                        print("error de suppression")
                    }
                    else
                    {
                        OperationQueue.main.addOperation(
                            { () -> Void in
                                self.liste.remove(at: (indexPath as NSIndexPath).row)
                                tableView.deleteRows(at: [indexPath], with: .automatic)
                        })
                    }
            })
        }
        
        print("la fonction est fini")
        
    }
    
    
    
    
// MARK: - Custum TableView
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.red
        let header  = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = .white
        
    }
    
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section == 0) {
            return "Pièces Détachées"
        }
        
        if (section == 1) {
            return "Liste des consomables (Coirroies)"
        }
        if(section == 2) {
            return "Liste des filtres "
            
        }
        
        if (section == 3) {
           
            return "Quantité de gaz présente dans l'installation "
        }
        return ""
    
    }
        
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(section == 0) {
            return 1
        }
        
        if (section == 1) {
            return coirroies.count
            
        }
        if(section == 2) {
            return filtres.count
        }
        if(section == 3) {
            return gaz.count
        }
           
        else {
            return 0
        }
    }
    
    
// MARK: - TableView DATA SOURCE
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableviewEdit.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustumTableViewCell
        if liste.count == 0 {
            return cell
        }
///////////////////////////////// Section O Piéce détachée /////////////////////////////////////////////
        
            if (indexPath.section == 0) {
                
                let switchDemo = UISwitch ()
                //switchDemo.center = CGPoint(x: 430, y: 104)
                switchDemo.isOn = true
                switchDemo.onTintColor = UIColor .brown
                cell.accessoryView = (switchDemo)
                cell.addSubview(switchDemo)
             
                
       let listeBati = liste[(indexPath as NSIndexPath).row]
       cell.LabelA?.text = listeBati.value(forKey: "nom") as? String
       cell.labelB?.text = listeBati.value(forKey: "details") as? String
     // -------------------------- image --------------------------------------------
        let imageAsset: CKAsset = listeBati.value(forKey: "image") as! CKAsset
        cell.imageCell?.image = UIImage(contentsOfFile: imageAsset.fileURL.path)
        cell.imageCell?.contentMode = UIViewContentMode.redraw
   
      
/////////////////////// Section 1 COIRROIES /////////////////////////////////////////////////////
            
            if (indexPath.section == 1) {
               
                let cell = tableviewEdit.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustumTableViewCell
               
                let switchDemo = UISwitch ()
                //switchDemo.center = CGPoint(x: 430, y: 104)
                switchDemo.isOn = true
                switchDemo.onTintColor = UIColor .brown
                cell.accessoryView = (switchDemo)
                cell.addSubview(switchDemo)
                
        let listeCoirroies = coirroies[(indexPath as NSIndexPath).row]
        cell.LabelA?.text = listeCoirroies.value(forKey: "taille") as? String
        cell.labelB?.text = listeCoirroies.value(forKey: "type") as? String
    
                }
   /*
////////////////////////////// Section 2 FITRES /////////////////////////////////////////////////
                
            if (indexPath.section == 2) {
                
                 let cell = tableviewEdit.dequeueReusableCell(withIdentifier: "Cellb", for: indexPath) as! CustumTableViewCell
                
                let listeFiltres = filtres[(indexPath as NSIndexPath).row]
                cell.LabelA?.text = listeFiltres.value(forKey: "largeur") as? String
                cell.labelB?.text = listeFiltres.value(forKey: "longeur") as? String
                //-------------------------- image ------------------------------------------------------
              //  let imageAsset: CKAsset = listeBati.value(forKey: "image") as! CKAsset
                //cell.imageCell?.image = UIImage(contentsOfFile: imageAsset.fileURL.path)
              //  cell.imageCell?.contentMode = UIViewContentMode.redraw
                
                }
                
/////////////////////////// Section 3 GAZ  ///////////////////////////////////////////////////////////////////////
           
           if (indexPath.section == 3)
            
            {
                 let cell = tableviewEdit.dequeueReusableCell(withIdentifier: "Cellc", for: indexPath) as! CustumTableViewCell
                
                let listeGaz = gaz[(indexPath as NSIndexPath).row]
                cell.LabelA?.text = listeGaz.value(forKey: "type") as? String
                cell.labelB?.text = listeGaz.value(forKey: "quantite") as? String
                //-------------------------- image ------------------------------------------------------
            
                    }
    
       */
        }
        
   
        return cell
    }
    
    
    // MARK: - Load Data
    
    
    
    func loadCoirroies () {
        
        self.refresh.beginRefreshing()
        
        let monContainaire = CKContainer.init(identifier: "iCloud.com.kerckweb.Swiffer")
        let privateData = monContainaire.publicCloudDatabase
        
        // let number = envoiLenomDuContrat
        
        // let predicate = "TRUEPREDICATE"
        
        
        let predicate = NSPredicate(format: "TRUEPREDICATE")
        let query = CKQuery(recordType: "Courroies", predicate: predicate)
        //  let query = CKQuery(recordType: "Data",
        // predicate: NSPredicate(format: "TRUEPREDICATE", argumentArray: nil))
        
        
        
        //  let customZone = CKRecordZone(zoneName: "Contrats")
        
        //  let query = CKQuery(recordType: "Batiment",
        
        
      //  query.sortDescriptors = [NSSortDescriptor(key: "nom", ascending: true)]
        
        
        privateData.perform(query, inZoneWith:nil) {
            (results, error) -> Void in
            
            if let contratRecup = results {
                self.coirroies = contratRecup
                
                // contratPass = mesContrats(value(forKey: "nomDuContrat")as? String)
                
                
                
                DispatchQueue.main.async(execute: { () -> Void in
                    
                    self.tableviewEdit.reloadData()
                    
                    self.refresh.endRefreshing()
                    
                    
                    // self.viewWait.isHidden = true
                })
            }
        }
        
    }
    @objc func loadFiltres () {
        
        self.refresh.beginRefreshing()
        
        let monContainaire = CKContainer.init(identifier: "iCloud.com.kerckweb.Swiffer")
        let privateData = monContainaire.publicCloudDatabase
        
        // let number = envoiLenomDuContrat
        
        // let predicate = "TRUEPREDICATE"
        
        
        let predicate = NSPredicate(format: "TRUEPREDICATE")
        let query = CKQuery(recordType: "Filtres", predicate: predicate)
        //  let query = CKQuery(recordType: "Data",
        // predicate: NSPredicate(format: "TRUEPREDICATE", argumentArray: nil))
        
        
        
        //  let customZone = CKRecordZone(zoneName: "Contrats")
        
        //  let query = CKQuery(recordType: "Batiment",
        
        
      //  query.sortDescriptors = [NSSortDescriptor(key: "nom", ascending: true)]
        
        
        privateData.perform(query, inZoneWith:nil) {
            (results, error) -> Void in
            
            if let contratRecup = results {
                self.filtres = contratRecup
                
                // contratPass = mesContrats(value(forKey: "nomDuContrat")as? String)
                
                
                
                DispatchQueue.main.async(execute: { () -> Void in
                    
                    self.tableviewEdit.reloadData()
                    
                    self.refresh.endRefreshing()
                    
                    
                    // self.viewWait.isHidden = true
                })
            }
        }
        
    }
    
    @objc func loadGaz () {
        
        self.refresh.beginRefreshing()
        
        let monContainaire = CKContainer.init(identifier: "iCloud.com.kerckweb.Swiffer")
        let privateData = monContainaire.publicCloudDatabase
        
        // let number = envoiLenomDuContrat
        
        // let predicate = "TRUEPREDICATE"
        
        
        let predicate = NSPredicate(format: "TRUEPREDICATE")
        let query = CKQuery(recordType: "Gaz", predicate: predicate)
        //  let query = CKQuery(recordType: "Data",
        // predicate: NSPredicate(format: "TRUEPREDICATE", argumentArray: nil))
        
        
        
        //  let customZone = CKRecordZone(zoneName: "Contrats")
        
        //  let query = CKQuery(recordType: "Batiment",
        
        
     //   query.sortDescriptors = [NSSortDescriptor(key: "nom", ascending: true)]
        
        
        privateData.perform(query, inZoneWith:nil) {
            (results, error) -> Void in
            
            if let contratRecup = results {
                self.gaz = contratRecup
                
                // contratPass = mesContrats(value(forKey: "nomDuContrat")as? String)
                
                
                
                DispatchQueue.main.async(execute: { () -> Void in
                    
                    self.tableviewEdit.reloadData()
                    
                    self.refresh.endRefreshing()
                    
                    
                    // self.viewWait.isHidden = true
                })
            }
        }
        
        
        
    }
    
    
 @objc func loadData ()
    {
      
        self.refresh.beginRefreshing()
        
        let monContainaire = CKContainer.init(identifier: "iCloud.com.kerckweb.Swiffer")
        let privateData = monContainaire.publicCloudDatabase
        
       // let number = envoiLenomDuContrat
        
       // let predicate = "TRUEPREDICATE"
        
      
        let predicate = NSPredicate(format: "TRUEPREDICATE")
        let query = CKQuery(recordType: "Data", predicate: predicate)
        //  let query = CKQuery(recordType: "Data",
                          // predicate: NSPredicate(format: "TRUEPREDICATE", argumentArray: nil))
       
      
        
        //  let customZone = CKRecordZone(zoneName: "Contrats")
        
        //  let query = CKQuery(recordType: "Batiment",
      
        
        query.sortDescriptors = [NSSortDescriptor(key: "nom", ascending: true)]
  
        
        privateData.perform(query, inZoneWith:nil) {
            (results, error) -> Void in
            
            if let contratRecup = results {
                self.liste = contratRecup
                
                // contratPass = mesContrats(value(forKey: "nomDuContrat")as? String)
                
                
                
                DispatchQueue.main.async(execute: { () -> Void in
                    
                    self.tableviewEdit.reloadData()
                    
                    self.refresh.endRefreshing()
                    
                    
                    // self.viewWait.isHidden = true
                })
            }
        }
        
        
    }

    
    
    
    
    
        // MARK: - Edit Action
    
    @IBAction func editAction(_ sender: UIBarButtonItem) {
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
