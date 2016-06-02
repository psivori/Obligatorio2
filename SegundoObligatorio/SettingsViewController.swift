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
    @IBOutlet weak var locationSettings: UISwitch!
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
        self.locationSettings.on = defaults.boolForKey("currentLocation")
        self.map.hidden = self.locationSettings.on;
        self.map.delegate = self
        //showing map with zoom and marker

        var pinLocation : CLLocationCoordinate2D = CLLocationCoordinate2DMake(defaults.doubleForKey("currentLatitude"), defaults.doubleForKey("currentLongitude"))
        var objectAnnotation = MKPointAnnotation()
        objectAnnotation.coordinate = pinLocation
        objectAnnotation.title = "yo"
        self.map.addAnnotation(objectAnnotation)
//        map.mapView(map, viewForAnnotation: objectAnnotation)
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
            defaults.setBool(self.locationSettings.on, forKey: "currentLocation")
            
            var annotation = self.map.annotations[0]
            defaults.setDouble(annotation.coordinate.latitude, forKey: "currentLatitude")
            defaults.setDouble(annotation.coordinate.longitude, forKey: "currentLongitude")
            
            let alert = UIAlertController(title: nil, message: "Los ajustes se actualizaron correctamente.", preferredStyle: UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default) { (action) in
                self.dismissViewControllerAnimated(true, completion: {})
            }
            alert.addAction(okAction)
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func changeLocationSettings(sender: UISwitch) {
        self.map.hidden = sender.on;
    }
    
}

extension SettingsViewController: MKMapViewDelegate {
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        if annotation is MKPointAnnotation {
            let pinAnnotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "myPin")
            
            pinAnnotationView.pinColor = .Green
            pinAnnotationView.draggable = true
            pinAnnotationView.canShowCallout = true
            pinAnnotationView.animatesDrop = true
            
            return pinAnnotationView
        }
        
        return nil
    }
}
