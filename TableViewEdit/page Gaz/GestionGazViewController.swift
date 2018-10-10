//
//  GestionGazViewController.swift
//  TableViewEdit
//
//  Created by Gаггу-Guииz  on 09/10/2018.
//  Copyright © 2018 KERCKWEB. All rights reserved.
//

import UIKit

class GestionGazViewController: UIViewController {
    
    @IBOutlet weak var pickerContrat: UIPickerView!
    @IBOutlet weak var boutonContrat: UIButton!
    @IBOutlet weak var labelContrat: UILabel!
    @IBOutlet weak var pickerBatiment: UIPickerView!
    var contratModelPicker: ModelPicker!
    var batimentModelPicker: ModelPicker!
    


    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Contrats
        contratModelPicker = ModelPicker ()
        contratModelPicker.modelContrat = Data.getData()
        
        pickerContrat.dataSource = contratModelPicker
        pickerContrat.delegate = contratModelPicker
        
        
        // Batiments
        batimentModelPicker = ModelPicker ()
        batimentModelPicker.modelContrat = Data.getDataBati()
       
        pickerBatiment.dataSource = batimentModelPicker
        pickerBatiment.delegate = batimentModelPicker
        
        
        
    }
    

    

}
