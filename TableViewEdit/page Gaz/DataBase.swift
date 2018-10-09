//
//  DataBase.swift
//  TableViewEdit
//
//  Created by Gаггу-Guииz  on 09/10/2018.
//  Copyright © 2018 KERCKWEB. All rights reserved.
//

import Foundation

class Data  {
    
    
    class func getData () ->[ContratModel] {
        
        var data  = [ContratModel]()
        
        data.append(ContratModel(nomContratPicker: "MMA"))
        data.append(ContratModel(nomContratPicker: "SNCF"))
        data.append(ContratModel(nomContratPicker: "GRDF"))
        data.append(ContratModel(nomContratPicker: "ERICSON"))
        data.append(ContratModel(nomContratPicker: "SONY"))
      return data
    }
    
}
