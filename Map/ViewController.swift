//
//  ViewController.swift
//  Map
//
//  Created by MacStudent on 2019-03-14.
//  Copyright © 2019 MacStudent. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate
{

    @IBOutlet weak var lblLat: UILabel!
    @IBOutlet weak var lblLng: UILabel!
    
    var locationManager:CLLocationManager! = nil
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        if let location = locations.first
        {
            print(location.coordinate)
            self.lblLat.text = "Latitude: \(location.coordinate.latitude)"
            self.lblLng.text = "Longitude: \(location.coordinate.longitude)"
        }
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus)
    {
        if(status == CLAuthorizationStatus.denied)
        {
            showLocationDisabledPopUp()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error :\(error)")
    }
    
    func showLocationDisabledPopUp()
    {
        let alertController = UIAlertController(title: "Background Location Access Disabled",
                                                message: "In order to deliver pizza we need your location",
                                                preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let openAction = UIAlertAction(title: "Open Settings", style: .default) { (action) in
            if let url = URL(string: UIApplication.openSettingsURLString)
            {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
}

}
