//
//  ViewController.swift
//  TestTaskMap
//
//  Created by user on 22.11.2022.
//

import UIKit
import MapKit
import CoreLocation

class MainViewController: UIViewController {
    
    var annotationsArray = [MKPointAnnotation]()
    
    let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.showsCompass = false

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
        
        mapView.delegate = self
        addSubview()
        setConstraints()
        addTargetButton()
    }
    
    @objc func addAdressButtonTapped() {
        
        alertAddAdress(title: "Добавить", placeholder: "Введите адрес") { [weak self] text in
            self?.setupaPlacemark(adressPlace: text)
        }
    }
    
    @objc func roadButtonTapped() {
        
        for index in 0...annotationsArray.count - 2 {
            
            createDirectionRequest(startCoordinate: annotationsArray[index].coordinate, destinationCoordinate: annotationsArray[index + 1].coordinate)
        }
        
        mapView.showAnnotations(annotationsArray, animated: true)
    }
    
    @objc func resetButtonTapped() {
        
        mapView.removeOverlays(mapView.overlays)
        mapView.removeAnnotations(mapView.annotations)
        annotationsArray = [MKPointAnnotation]()
        
        roadButton.isHidden = true
        resetButton.isHidden = true
        
    }
    
    private func addSubview() {
        
        view.addSubview(mapView)
        mapView.addSubview(addAdressButton)
        mapView.addSubview(roadButton)
        mapView.addSubview(resetButton)
    }
    
    private func addTargetButton() {
        
        addAdressButton.addTarget(self,action: #selector(addAdressButtonTapped), for: .touchUpInside)
        roadButton.addTarget(self, action: #selector(roadButtonTapped), for: .touchUpInside)
        resetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
    }
    
    private func setupaPlacemark(adressPlace: String) {
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(adressPlace) { [self] placemarks, error in
            if let error = error {
                print(error)
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
            
            if annotationsArray.count > 1 {
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
        request.transportType = .automobile
        
        let direction = MKDirections(request: request)
        direction.calculate { responce, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let responce = responce else {
                self.alertError(title: "Ошибка", message: "Маршрут недоступен")
                return
                
            }
            var minRoute = responce.routes[0]
            for route in responce.routes {
                minRoute = (route.distance < minRoute.distance) ? route : minRoute
            }
            
            self.mapView.addOverlay(minRoute.polyline)
            
        }
    }
}

extension MainViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        renderer.strokeColor = .red
        return renderer
    }
    
}

extension MainViewController {
    
    func setConstraints() {
        
        mapView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            mapView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
        
        addAdressButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addAdressButton.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 40),
            addAdressButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -20),
            addAdressButton.heightAnchor.constraint(equalToConstant: 70),
            addAdressButton.widthAnchor.constraint(equalToConstant: 70)
        ])
        
        roadButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            roadButton.leadingAnchor.constraint(equalTo: mapView.leadingAnchor, constant: 20),
            roadButton.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -30),
            roadButton.heightAnchor.constraint(equalToConstant: 50),
            roadButton.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            resetButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -20),
            resetButton.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -30),
            resetButton.heightAnchor.constraint(equalToConstant: 50),
            resetButton.widthAnchor.constraint(equalToConstant: 100)
        
        
        ])
    }
}
