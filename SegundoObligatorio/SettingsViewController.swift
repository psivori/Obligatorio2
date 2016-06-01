//
//  SettingsViewController.swift
//  SegundoObligatorio
//
//  Created by Administrador on 27/5/16.
//  Copyright © 2016 Universidad Catolica. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    let defaults = NSUserDefaults.standardUserDefaults()
    @IBOutlet weak var units: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    @IBAction func save(sender: AnyObject) {
        if let selected = Units(rawValue: units.selectedSegmentIndex){
            defaults.setObject(String(selected), forKey: "units")
            let alert = UIAlertController(title: nil, message: "Se actualizaron las unidades correctamente.", preferredStyle: UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default) { (action) in
                self.dismissViewControllerAnimated(true, completion: {})
            }
            alert.addAction(okAction)
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
       //
    }
    
}
