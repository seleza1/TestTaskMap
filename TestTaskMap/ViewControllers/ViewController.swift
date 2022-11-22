//
//  ViewController.swift
//  TestTaskMap
//
//  Created by user on 22.11.2022.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {
    
    let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }


}

extension ViewController {
    func setConstraints() {
        
        view.addSubview(mapView)
        
        NSLayoutConstraint.activate([
            
            
        
        
        
        
        ])
    }
}
