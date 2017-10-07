//
//  GooglePlacesApiCall.swift
//  Near Me
//
//  Created by Raj Shah on 08/08/17.
//  Copyright © 2017 Raj Shah. All rights reserved.
//
import CoreLocation
import Foundation
import Alamofire




public class GooglePlaceApi: NSObject{
    fileprivate var googleApiKey: String = ""
    fileprivate var latitude: String = ""
    fileprivate var longtitude: String = ""
    
    public init(googlePlacesApikey: String){
        super.init()
        self.googleApiKey = googlePlacesApikey
       
    }
    
    //this function is UsedFor Getting googlePlacesApi anyWhere
    private func getGoogleKey() -> String{
        return UserDefaults.standard.object(forKey: "googleApiKey") as! String
    }
    
    
    //This function will store api key to NSUserDefaults
    private func setGoogleApiKey(_ value : String){
        UserDefaults.standard.set(value, forKey: "googleApiKey")
        UserDefaults.standard.synchronize()
    }
    
    
    
    class func placeDetail(_ placeId: String, success: @escaping (_ placeDetail: PlaceDetail)->Void){
        var urlRequest: URLRequest = URLRequest.init(url: URL(string: "https://maps.googleapis.com/maps/api/place/details/json?placeid=\(placeId)&key=AIzaSyB7yYN2Wtc7PEkneyWfVmF1SXVQomcT9k0")!, cachePolicy: URLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: 10.0)
        urlRequest.httpMethod = "Get"
        print(urlRequest)
        Alamofire.request(urlRequest).responseJSON { (jsonResponse) in
            let responseDictionary = jsonResponse.result.value as! NSDictionary
            let placeDetails: PlaceDetail = PlaceDetail(responseDictionary)
            success(placeDetails)
        }
    }
    
    
}
extension GooglePlaceApi: CLLocationManagerDelegate{
    
    
    //get Location Setup
    public func getLocation(_ delegate: CLLocationManagerDelegate? , locationManager: CLLocationManager){
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = delegate
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            if CLLocationManager.authorizationStatus() == .notDetermined {
                locationManager.requestWhenInUseAuthorization()
            }
            if CLLocationManager.locationServicesEnabled() {
                locationManager.startUpdatingLocation()
            }
        }
    }
    
    
    //error in this code find
    //getLocationDelegate
    public func setupDelegateForLoction(_ manager: CLLocationManager, locations: [CLLocation]){
        let userLocation:CLLocation = locations[locations.count - 1] as CLLocation
        manager.stopUpdatingLocation()
        let coordinations = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude,longitude: userLocation.coordinate.longitude)
        self.latitude = String(coordinations.latitude)
        self.longtitude = String(coordinations.longitude)
        delegate?.googlePlacesApiLocationDidGet(userLocation)
      print(self.latitude + "    " + self.longtitude)
    }
}
