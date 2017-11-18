//
//  PlaceDetailsViewController.swift
//  Near Me
//
//  Created by Raj Shah on 05/10/17.


import UIKit
import Alamofire
class PlaceDetailsViewController: UIViewtroller {

    var id: String = ""
    
    @IBOutlet var collectionView: UICollectionView?
    @IBOutlet var nameLabel: UILabel?
    @IBOutlet var addressLabel: UILabel?
    @IBOutlet var PhoneLabel: UILabel?
    @IBOutlet var isOpenLabel: UILabel?
    @IBOutlet weak var RatingLabel: UILabel!
    
    //erroors solved.
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
  //errors in the code.solved,
    @IBAction func onClickCall(_ sender: Any) {
        //if let url = URL(string: "tel://\(phoneNumbers)") {
        //UIApplication.shared.open(URL(string: "tel://\(phoneNumbers)")!, options: [:], completionHandler: nil)
        //}
    }
   
    

    /*
    // MARK: - Navigation
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
