//
//  ExtensionLocation.swift
//  osraty-user_ios
//
//  Created by apple on 4/5/20.
//  Copyright © 2020 panorama. All rights reserved.
//

import Foundation
import CoreLocation


class LocationManager: NSObject , CLLocationManagerDelegate{
    
    // MARK: - Singleton
    static let SharedInstans = LocationManager()
    
    // MARK: - Properties
    var locationManager: CLLocationManager!
    
    
    override init(){
        super.init()
        setuoLocationManager()
    }
    
    // MARK: - Configuration
    private func setuoLocationManager() {
        locationManager = CLLocationManager();
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        var currentLoc: CLLocation!
        
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()

    }
    
    func LocationIsEnable()->Bool{
        if locationManager.location != nil {
            return true
        } else {
            return false
        }
    }
    
    func getlongitude()->Double{
        return (locationManager.location?.coordinate.longitude ?? 0.0)
    }
    
    func getlatitude()->Double{
        return  (locationManager.location?.coordinate.latitude ?? 0.0)
    }

    func calculateDistance(destinationLat:Double,destinationLog:Double)->CLLocationDistance{
        let coordinateSource = CLLocation(latitude: getlatitude(), longitude: getlongitude())
        let coordinateDistination = CLLocation(latitude: destinationLat, longitude: destinationLog)
        return Double(round(1000*coordinateSource.distance(from: coordinateDistination))/1000)
    }
}
