//
//  GooglePlacesApiCallAndResponse.swift
//  Near Me
//
//  Created by Raj Shah on 29/07/17.
//  Copyright © 2017 Raj Shah. All rights reserved.
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
    public var placeLocation: CLLocationCoordinate2D = CLLocationCoordinate2D()
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
        
        placeLocation = CLLocationCoordinate2D.init(latitude: Double(latitude), longitude: Double(longtitude))
    }
    
}
public class PlaceDetail{
    public var placeName: String = ""
    public var placeAddress: String = ""
    public var phoneNumber: String = ""
    public var url: String = ""
    public var isOpenNow: Bool = false
    public var rating: String = ""
    public var photoIds: [String] = []
    public init(_ dictionary: NSDictionary){
        let resultDic: NSDictionary = dictionary.value(forKey: "result") as! NSDictionary
        if let temp = resultDic.value(forKey: "name"){
            placeName = temp as! String
        }
        if let temp = resultDic.value(forKey: "vicinity"){
            placeAddress = temp as! String
        }
        if let temp = resultDic.value(forKey: "international_phone_number"){
            phoneNumber = temp as! String
        }
        if let temp = resultDic.value(forKey: "rating") as? Float{
            rating = String(temp)
        }//url
        if let temp = resultDic.value(forKey: "url") as? String{
            url = String(temp)
        }
        if let temp = resultDic.value(forKey: "opening_hours") as? NSDictionary{
            if let temp1 = temp.value(forKey: "open_now") as? Bool{
                self.isOpenNow = temp1
            }
        }
        if let temp = resultDic.value(forKey: "photos") as? NSArray{
            for temps in temp{
                if let temp2 = temps as? NSDictionary{
                    if let temp3 = temp2.value(forKey: "photo_reference") as? String{
                        self.photoIds.append("https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=\(temp3)&key=AIzaSyB7yYN2Wtc7PEkneyWfVmF1SXVQomcT9k0")
                    }
                }
            }
        }
    }
}



class Webservices {
 
}
