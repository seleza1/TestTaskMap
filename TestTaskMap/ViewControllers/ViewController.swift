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
    
    let addAdressButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add adress", for: .normal)
        button.titleLabel?.numberOfLines = 0
        button.backgroundColor = .red
        button.contentHorizontalAlignment = .center
        button.layer.cornerRadius = 35
        return button
    }()
    
    let roadButton: UIButton = {
        let button = UIButton()
        button.setTitle("Road", for: .normal)
        button.backgroundColor = .green
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let resetButton: UIButton = {
        let button = UIButton()
        button.setTitle("Reset", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 15
        button.backgroundColor = .red
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setConstraints()
        
        addAdressButton.addTarget(self,action: #selector(addAdressButtonTapped), for: .touchUpInside)
        roadButton.addTarget(self, action: #selector(roadButtonTapped), for: .touchUpInside)
        resetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
        
    }
    
    @objc func addAdressButtonTapped() {
        print("addTapped")
        
        
    }
    
    @objc func roadButtonTapped() {
        print("tappedRoad")
        
    }
    
    @objc func resetButtonTapped() {
        print("tappedReset")
        
    }
}

extension ViewController {
    
    func setConstraints() {
        
        view.addSubview(mapView)
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            mapView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
        
        mapView.addSubview(addAdressButton)
        NSLayoutConstraint.activate([
            addAdressButton.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 50),
            addAdressButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -20),
            addAdressButton.heightAnchor.constraint(equalToConstant: 70),
            addAdressButton.widthAnchor.constraint(equalToConstant: 70)
        
        
        ])
        
        mapView.addSubview(roadButton)
        NSLayoutConstraint.activate([
            roadButton.leadingAnchor.constraint(equalTo: mapView.leadingAnchor, constant: 20),
            roadButton.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -30),
            roadButton.heightAnchor.constraint(equalToConstant: 50),
            roadButton.widthAnchor.constraint(equalToConstant: 100)
        
        
        ])
        
        mapView.addSubview(resetButton)
        NSLayoutConstraint.activate([
            resetButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -20),
            resetButton.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -30),
            resetButton.heightAnchor.constraint(equalToConstant: 50),
            resetButton.widthAnchor.constraint(equalToConstant: 100)
        
        
        ])

        
        
    }
}
