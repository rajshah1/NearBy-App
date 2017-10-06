//
//  MapViewController.swift
//  Near Me
//
//  Created by Raj Shah on 14/09/17.
//  Copyright © 2017 Raj Shah. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    let googleCall: GooglePlaceApi = GooglePlaceApi.init(googlePlacesApikey: "AIzaSyB7yYN2Wtc7PEkneyWfVmF1SXVQomcT9k0")
    let locationManger:CLLocationManager = CLLocationManager()
    var placesArray: [Place] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        googleCall.getLocation(self, locationManager: locationManger)
         googleCall.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension MapViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        googleCall.setupDelegateForLoction(manager, locations: locations)

    }
}
extension MapViewController: GooglePlacesApiDelegete{
    
    func googlePlacesApiLocationDidGet(_ location: CLLocation) {
        googleCall.getGooglePlacesList((parent as! PlacesTabBar).placeType) { (place) in
            self.placesArray = place.places
            for place in self.placesArray{
                let annotaion = MKPointAnnotation()
                annotaion.coordinate = place.placeLocation
                annotaion.title = place.placeName
                self.mapView.addAnnotation(annotaion)
            }
            let noLocation = location.coordinate
            let viewRegion = MKCoordinateRegionMakeWithDistance(noLocation, 2000, 2000)
            self.mapView.setRegion(viewRegion, animated: false)
        }
    }
}
