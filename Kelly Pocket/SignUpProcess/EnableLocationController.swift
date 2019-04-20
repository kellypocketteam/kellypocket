//
//  EnableLocationController.swift
//  Kelly Pocket
//
//  Created by Ed Basurto on 4/15/19.
//  Copyright © 2019 Ed Basurto. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class EnableLocationController: UIViewController, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
        
    }
    
    @IBAction func enableLocationServices() {
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() == true {
            let vc = self.storyboard!.instantiateViewController(withIdentifier: "Review")
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func skipLocationServices() {
        let alertController = UIAlertController(title: "Enable later", message: "You can enable location services later under settings.", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Okay", style: .cancel) { (alert) in
            let vc = self.storyboard!.instantiateViewController(withIdentifier: "Review")
            self.present(vc, animated: true, completion: nil)
        }
        alertController.addAction(cancel)
        self.present(alertController, animated: true, completion: nil)
    }
    
}

