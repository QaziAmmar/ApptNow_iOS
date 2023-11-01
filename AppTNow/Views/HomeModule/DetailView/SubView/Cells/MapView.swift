//
//  MapView.swift
//  AppTNow
//
//  Created by Qazi Mudassar on 19/08/2023.
//


import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    
    var latitude: Double
    var longitude: Double
    
    var locationManager = CLLocationManager()
    func setupManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
    }
    
    
    func makeUIView(context: Context) -> MKMapView {
        setupManager()
        let mapView = MKMapView(frame: UIScreen.main.bounds)
        mapView.delegate = context.coordinator
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 100, longitudinalMeters: 100)

        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "Location"
        mapView.addAnnotation(annotation)
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        let marker = MKPointAnnotation()
        marker.title = "Bath Location"
        marker.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        uiView.addAnnotation(marker)
    }
    
    func makeCoordinator() -> MapViewCoordinater {
        return MapView.MapViewCoordinater()
    }
    
    class MapViewCoordinater: NSObject, MKMapViewDelegate {
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            
            let identifier = "MyPin"
            
            if annotation is MKUserLocation {
                return nil
            }
            
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            
            if annotationView == nil {
                
                annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.canShowCallout = true
                annotationView?.image = UIImage(named: "location")
            } else {
              
                annotationView?.annotation = annotation
            }
            
            return annotationView
        }
    }
}


#if DEBUG
struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(latitude: 31.520370, longitude: 74.358749)
    }
}
#endif
