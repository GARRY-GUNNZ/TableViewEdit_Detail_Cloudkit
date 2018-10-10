//
//  DataBase.swift
//  TableViewEdit
//
//  Created by Gаггу-Guииz  on 09/10/2018.
//  Copyright © 2018 KERCKWEB. All rights reserved.
//

import Foundation
import CloudKit


class Data {
   
     
    
    class func getData () ->[ContratModel] {
        
        var data  = [ContratModel]()
        
        data.append(ContratModel(nomContratPicker: "MMA"))
        data.append(ContratModel(nomContratPicker: "SNCF"))
        data.append(ContratModel(nomContratPicker: "GRDF"))
        data.append(ContratModel(nomContratPicker: "ERICSON"))
        data.append(ContratModel(nomContratPicker: "SONY"))
        return data
    }
    
    
    class func getDataBati () ->[ContratModel] {
        
        var databatiment  = [ContratModel]()
        
        databatiment.append(ContratModel(nomContratPicker: "MMA1"))
        databatiment.append(ContratModel(nomContratPicker: "SNCF1"))
        databatiment.append(ContratModel(nomContratPicker: "GRDF1"))
        databatiment.append(ContratModel(nomContratPicker: "ERICSON1"))
        databatiment.append(ContratModel(nomContratPicker: "SONY1"))
        return databatiment
    }
    
}
