//
//  MapViewController.swift
//  MeepAlbert
//
//  Created by Albert on 27/08/2020.
//  Copyright © 2020 Albert. All rights reserved.
//

import UIKit
import GoogleMaps
import RealmSwift
import RxSwift
import RxGoogleMaps

class MapViewController: UIViewController {
    
    // MARK: - PROPERTIES
    let lowerLeftCoordinates = Coordinates(lat: 38.711046, long: -9.160096)
    let upperRightCoordinates = Coordinates(lat: 38.739429, long: -9.137115)
    
    let disposeBag = DisposeBag()
    
    var colors = Dictionary<Int, UIColor>()
    
    // MARK: - FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let camera = GMSCameraPosition.camera(withLatitude: (lowerLeftCoordinates.lat + upperRightCoordinates.lat) / 2, longitude: (lowerLeftCoordinates.lon + upperRightCoordinates.lon) / 2, zoom: 16)
        let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        self.view.addSubview(mapView)
        
        
        // Update map whenever user ends scrolling
        mapView.rx.idleAt
            .subscribe(onNext: {
                print($0)
                self.updateResources(mapView)
            })
            .disposed(by: disposeBag)
        
    }
    
    func updateResources(_ mapView: GMSMapView) {
        _ = Resource.lisboa(lowerLeftCoordinates: lowerLeftCoordinates, upperRightCoordinates: upperRightCoordinates) { (success, error) in
            
            mapView.clear()
            
            let resources = Resource.all
            
            resources.forEach { (resource) in
                if self.colors[resource.companyZoneId] == nil {
                    self.colors[resource.companyZoneId] = UIColor.randomColor
                }
                
                let marker = GMSMarker()
                marker.position = CLLocationCoordinate2D(latitude: resource.lat, longitude: resource.lon)
                marker.title = resource.name
                marker.icon = GMSMarker.markerImage(with: self.colors[resource.companyZoneId])
                marker.map = mapView
            }
        }
    }
    
    
}
