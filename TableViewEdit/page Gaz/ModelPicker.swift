//
//  ModelPicker.swift
//  TableViewEdit
//
//  Created by Gаггу-Guииz  on 09/10/2018.
//  Copyright © 2018 KERCKWEB. All rights reserved.
//

import UIKit

class ModelPicker: UIPickerView {

    var modelContrat : [ContratModel]!
    
}

extension ModelPicker: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
         return modelContrat.count
    }
    
}

extension ModelPicker: UIPickerViewDelegate {
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return modelContrat[row].nomContratPicker
    }

}
    
    

