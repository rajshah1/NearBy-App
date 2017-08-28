//
//  GooglePlacesApiCallAndResponse.swift
//  Near Me
//
//  Created by Anshul Shah on 29/07/17.
//  Copyright © 2017 Anshul Shah. All rights reserved.
//

import Foundation
import Alamofire
import MapKit
public class PlacesList{
    public var nextPageToken: String = ""
    public var places: [Place] = []
    public init(_ dictionary: NSDictionary){
        if let token = dictionary.value(forKey: "next_page_token"){
            nextPageToken = token as! String
        }
        if dictionary.value(forKey: "results") != nil{
            let resultArray: [NSDictionary] = dictionary.value(forKey: "results") as! [NSDictionary]
            if(resultArray.count != 0){
                for i in 0...resultArray.count-1{
                    let place: Place = Place.init(resultArray[i])
                    places.append(place)
                }
            }
        }
    }
}
public class Place{
    public var placeName: String = ""
    public var placeAddress: String = ""
    public var placeID: String = ""
    public var placeLocation: CLLocation = CLLocation()
    public init(_ dictionary: NSDictionary){
        if let temp = dictionary.value(forKey: "name"){
            placeName = temp as! String
        }
        if let temp = dictionary.value(forKey: "vicinity"){
            placeAddress = temp as! String
        }
        if let temp = dictionary.value(forKey: "place_id"){
            placeID = temp as! String
        }
        let latitude = dictionary.value(forKeyPath: "geometry.location.lat") as! Double
        let longtitude = dictionary.value(forKeyPath: "geometry.location.lng") as! Double
        
        placeLocation = CLLocation.init(latitude: Double(latitude), longitude: Double(longtitude))
    }
    
}



class Webservices {
 
}
