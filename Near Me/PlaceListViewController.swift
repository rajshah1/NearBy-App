//
//  PlaceListViewController.swift
//  Near Me
//
//  Created by Anshul Shah on 21/07/17.
//  Copyright © 2017 Anshul Shah. All rights reserved.
//

import UIKit
import CoreLocation


class PlaceListViewController: UIViewController {
    
    let googleCall: GooglePlaceApi = GooglePlaceApi.init(googlePlacesApikey: "AIzaSyB7yYN2Wtc7PEkneyWfVmF1SXVQomcT9k0")
    let locationManger:CLLocationManager = CLLocationManager()
    var placesArray: [Place] = []
    
    @IBOutlet weak var tableView: UITableView!
  

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "PlaceListTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        googleCall.getLocation(self, locationManager: locationManger)
        googleCall.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
extension PlaceListViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placesArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PlaceListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PlaceListTableViewCell
        cell.placeNameLabel.text = "Place name \(indexPath.row + 1)" /*placesArray[indexPath.row].placeName*/
        cell.placeAddressLabel.text = "Place Address \(indexPath.row + 1)"/*placesArray[indexPath.row].placeAddress*/
        return cell
    }
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
  
}
extension PlaceListViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        googleCall.setupDelegateForLoction(manager, locations: locations)
    }
}
extension PlaceListViewController: GooglePlacesApiDelegete{
    func googlePlacesApiLocationDidGet() {
        googleCall.getGooglePlacesList((parent as! PlacesTabBar).placeType) { (place) in
            self.placesArray = place.places
            self.tableView.reloadData()
        }
    }
}
