//
//  PlaceListViewController.swift
//  Near Me
//
//  Created by Raj Shah on 21/07/17.


import UIKit
import CoreLocation


class PlaceListViewController: UIViewController {
    
    let googleCall: GooglePlaceApi = GooglePlaceApi.init(googlePlacesApikey: "AIzaSyB7yYN2Wtc7PEkneyWfVmF1SXVQomcT9k0")
    let locationManger:CLLocationManager = CLLocationManager()
    var placesArray: [Place] = []
    var selectedPlaceId: String = ""
    var selectedIndex: Int = 0
    @IBOutlet weak var tableView: UITableView!
  

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "PlaceListTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        googleCall.getLocation(self, locationManager: locationManger)
        googleCall.delegate = self
        // Do any additional setup after loading the view.
    }

   
    
    @IBAction func onClickBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "segue"){
            let vc = segue.destination as! PlaceDetailsViewController
            vc.id = selectedPlaceId
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
 

}
extension PlaceListViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placesArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PlaceListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PlaceListTableViewCell
        cell.placeNameLabel.text = placesArray[indexPath.row].placeName
        cell.placeAddressLabel.text = placesArray[indexPath.row].placeAddress
        selectedIndex = indexPath.row
        cell.placeCallButton.tag = indexPath.row
        cell.isUserInteractionEnabled = true
        return cell
    }


    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedPlaceId = self.placesArray[indexPath.row].placeID
        self.performSegue(withIdentifier: "segue", sender: self)
    }
  
}
extension PlaceListViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        googleCall.setupDelegateForLoction(manager, locations: locations)
    }
}
extension PlaceListViewController: GooglePlacesApi{
    func googlePlacesApiLocationDidGet(_ location: CLLocation) {
        googleCall.getGooglePlacesList((parent as! PlacesTabBar).placeType) { (place) in
            self.placesArray = place.places
            self.tableView.reloadData()
            let parent = self.parent as? PlacesTabBar
            parent?.places = place.places
        }
    }
}
