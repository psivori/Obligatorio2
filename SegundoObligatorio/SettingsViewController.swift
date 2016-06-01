//
//  SettingsViewController.swift
//  SegundoObligatorio
//
//  Created by Administrador on 27/5/16.
//  Copyright © 2016 Universidad Catolica. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var units: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func cancel(sender: AnyObject) {
        var viewController = self.storyboard!.instantiateViewControllerWithIdentifier("viewController")
        navigationController?.popToViewController(viewController, animated: true)
    }
    
    @IBAction func save(sender: AnyObject) {
        print("save")
    }
    
}
