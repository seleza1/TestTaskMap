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
    
    var annotationsArray = [MKPointAnnotation]()
    
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
        button.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        button.contentHorizontalAlignment = .center
        button.layer.cornerRadius = 35
        return button
    }()
    
    let roadButton: UIButton = {
        let button = UIButton()
        button.setTitle("Road", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0, green: 1, blue: 0.2726448476, alpha: 1)
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        return button
    }()
    
    let resetButton: UIButton = {
        let button = UIButton()
        button.setTitle("Reset", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 15
        button.backgroundColor = .red
        button.isHidden = true
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
        alertAddAdress(title: "Добавить", placeholer: "Введите адрес") { [weak self] text in
            self?.setupaPlacemark(adressPlace: text)
        }
    }
    
    @objc func roadButtonTapped() {
        print("tappedRoad")
        
    }
    
    @objc func resetButtonTapped() {
        print("tappedReset")
        
    }
    
    private func setupaPlacemark(adressPlace: String) {
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(adressPlace) { [self] placemarks, error in
            if let error = error {
                print(error.localizedDescription)
                 alertError(title: "Error", message: "Server not found")
                return
            }
            
            guard let placemarks = placemarks else { return }
            let placemark = placemarks.first
            
            let annotation = MKPointAnnotation()
            annotation.title = "\(adressPlace)"
            
            guard let placeMarkLocation = placemark?.location else { return }
            annotation.coordinate = placeMarkLocation.coordinate
            
            annotationsArray.append(annotation)
            
            if annotationsArray.count > 2 {
                roadButton.isHidden = false
                resetButton.isHidden = false
            }
            
            mapView.showAnnotations(annotationsArray, animated: true)
        }
    }
    
    private func createDirectionRequest(startCoordinate: CLLocationCoordinate2D, destinationCoordinate: CLLocationCoordinate2D ) {
        
        let startLocation = MKPlacemark(coordinate: startCoordinate)
        let destinationLocation = MKPlacemark(coordinate: destinationCoordinate)
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: startLocation)
        request.destination = MKMapItem(placemark: destinationLocation)
        request.transportType = .walking
        request.highwayPreference = .any
        
        let direction = MKDirections(request: request)
        direction.calculate { response, error in
            <#code#>
        }
        
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
            addAdressButton.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 40),
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
