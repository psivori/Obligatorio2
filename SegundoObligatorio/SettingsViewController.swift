//
//  SettingsViewController.swift
//  SegundoObligatorio
//
//  Created by Administrador on 27/5/16.
//  Copyright © 2016 Universidad Catolica. All rights reserved.
//

import UIKit
import MapKit

class SettingsViewController: UIViewController {

    let defaults = NSUserDefaults.standardUserDefaults()
    @IBOutlet weak var units: UISegmentedControl!
    @IBOutlet weak var location: UISwitch!
    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setting selected units
        var savedUnits = defaults.stringForKey("units")
        if savedUnits == String(Units.metric){
            units.selectedSegmentIndex = 0
        }else{
            units.selectedSegmentIndex = 1
        }
        
        //setting selected location
        
        //showing map with zoom and marker
        var pinLocation : CLLocationCoordinate2D = CLLocationCoordinate2DMake(defaults.doubleForKey("currentLatitude"), defaults.doubleForKey("currentLongitude"))
        var objectAnnotation = MKPointAnnotation()
        objectAnnotation.coordinate = pinLocation
        objectAnnotation.title = "yo"
        self.map.addAnnotation(objectAnnotation)
        var span = MKCoordinateSpanMake(0.075, 0.075)
        var region = MKCoordinateRegion(center: pinLocation, span: span)
        self.map.setRegion(region, animated: true)
    }
    
    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    @IBAction func save(sender: AnyObject) {
        if let selected = Units(rawValue: units.selectedSegmentIndex){
        defaults.setObject(String(selected), forKey: "units")
        //defaults.setObject(, forKey: "coordinates")
        let alert = UIAlertController(title: nil, message: "Los ajustes se actualizaron correctamente.", preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default) { (action) in
           self.dismissViewControllerAnimated(true, completion: {})
        }
        alert.addAction(okAction)
        self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func changeLocationSettings(sender: AnyObject) {
        self.map.hidden = self.location.selected;
    }
    
}
