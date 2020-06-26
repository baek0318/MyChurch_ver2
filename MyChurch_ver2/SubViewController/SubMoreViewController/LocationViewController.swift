//
//  LocationViewController.swift
//  MyChurch_ver2
//
//  Created by 백승화 on 2020/06/04.
//  Copyright © 2020 백승화. All rights reserved.
//

import UIKit
import MapKit
import Contacts

class LocationViewController : UIViewController {
    
    @IBOutlet var titleName: UILabel!
    var saveTitle : String?
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        self.titleName.text = saveTitle
        addMap()
        super.viewDidLoad()
    }
    
    @IBAction func moveToBack(_ sender: Any) {
        self.dismiss(animated: true)
        
    }
    
    func addMap() {
        mapView.delegate = self
        let initialLocation = CLLocation(latitude: 35.8235775, longitude: 128.521810)
        mapView.centerToLocation(initialLocation)
        
        mapView.addAnnotation(Annotation(title: "대흥교회", locationName: "대구를 사랑하는 대흥교회" ,coordinate: CLLocationCoordinate2D(latitude: 35.8235775, longitude: 128.521810)))
    }
}

//MARK:- extension MKMapView

private extension MKMapView {
    func centerToLocation(_ location : CLLocation, regionRadius : CLLocationDistance = 200){
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
}

extension LocationViewController : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation as? Annotation else {return}
        let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
        annotation.mapItem?.openInMaps(launchOptions: launchOptions)
    }
}
//MARK:- MKAnnotation

class Annotation : NSObject, MKAnnotation {
    let title : String?
    let locationName : String?
    let coordinate : CLLocationCoordinate2D
    
    init(title : String?, locationName : String? ,coordinate : CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.coordinate = coordinate
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
    
    var mapItem : MKMapItem? {
        guard let location = locationName else {return nil}
        
        let addressDict = [CNPostalAddressStreetKey : location]
        let placeMark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
        let mapItem = MKMapItem(placemark: placeMark)
        mapItem.name = title
        return mapItem
    }
}
