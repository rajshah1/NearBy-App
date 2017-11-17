//
//  PlaceDetailsViewController.swift
//  Near Me
//
//  Created by Raj Shah on 05/10/17.
//  Copyright © 2017 Raj Shah. All rights reserved.
//

import UIKit
import Alamofire
import CoreData
class PlaceDetailsViewController: UIViewController {

    var id: String = ""
    
    @IBOutlet var collectionView: UICollectionView?
    @IBOutlet var nameLabel: UILabel?
    @IBOutlet var addressLabel: UILabel?
    @IBOutlet var PhoneLabel: UILabel?
    @IBOutlet var isOpenLabel: UILabel?
    @IBOutlet weak var RatingLabel: UILabel!
    
    
    @IBOutlet weak var webBTN: UIButton!
    @IBOutlet weak var callBTN: UIButton!
    var phoneNumbers: String = ""
    var imageTokens: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        callBTN.isEnabled = false
        webBTN.isEnabled = false
        GooglePlaceApi.placeDetail(id) { (place) in
            self.nameLabel?.text = place.placeName
            self.addressLabel?.text = place.placeAddress
            self.PhoneLabel?.text = place.phoneNumber
            self.phoneNumbers = place.phoneNumber
            if place.isOpenNow{
                self.isOpenLabel?.text =  "Open Now"
                self.isOpenLabel?.textColor = .green
            }else{
                self.isOpenLabel?.text =  "Close now"
                self.isOpenLabel?.textColor = .red
                
            }
            if(place.phoneNumber != ""){
                self.callBTN.isEnabled = true
            }
            if(place.phoneNumber != ""){
                self.webBTN.isEnabled = true
            }
            self.imageTokens = place.photoIds
            self.collectionView?.reloadData()
            self.RatingLabel.text = place.rating
        }
        // Do any additional setup after loading the view.
    }
    @IBAction func onClickAddToFavourite(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let favourites = Favourites(context: context) // Link Task & Context
        favourites.favouriteID = id
        favourites.favoriteName = nameLabel?.text!
        favourites.favouriteVicinity = addressLabel?.text!
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
    @IBAction func onClickCall(_ sender: Any) {
        //if let url = URL(string: "tel://\(phoneNumbers)") {
        //UIApplication.shared.open(URL(string: "tel://\(phoneNumbers)")!, options: [:], completionHandler: nil)
        //}
    }
    
    @IBAction func onClickWeb(_ sender: Any) {
    }
    @IBAction func onClickBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //  of any resources that can be recreated.
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
extension PlaceDetailsViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageTokens.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! imageCell
        Alamofire.request(imageTokens[indexPath.row]).responseData{ response in
            if let image = response.result.value {
                cell.imageView?.image = UIImage(data: image)
            }
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        collectionView.layoutIfNeeded()
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}
class imageCell: UICollectionViewCell{
    @IBOutlet var imageView: UIImageView?
}
