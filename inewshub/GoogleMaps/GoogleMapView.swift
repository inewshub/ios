//
//  GoogleMapView.swift
//  inewshub
//
//  Created by seevsk on 23/11/25.
//

import SwiftUI
import GoogleMaps

struct GoogleMapView: UIViewRepresentable {

    let facility: Facility

    func makeUIView(context: Context) -> GMSMapView {
        
        let lat = facility.latitude ?? 0
        let lon = facility.longitude ?? 0
        
        let camara = GMSCameraPosition.camera(
            withLatitude: lat,
            longitude: lon,
            zoom: 16.0
        )
        
        let mapView = GMSMapView()
        mapView.camera = camara
        return mapView
    }

    func updateUIView(_ uiView: GMSMapView, context: Context) {
        
        uiView.clear()
        
        let lat = facility.latitude ?? 0
        let lon = facility.longitude ?? 0
        
        let position = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        
        let marker = GMSMarker()
        marker.position = position
        marker.title = facility.name
        marker.snippet = " \(facility.stars) estrellas"
        marker.map = uiView
        
        let circle = GMSCircle(position: position, radius: 500)
        circle.fillColor = UIColor.red.withAlphaComponent(0.2)
        circle.strokeColor = .red
        circle.strokeWidth = 2
        circle.map = uiView
    }
}

