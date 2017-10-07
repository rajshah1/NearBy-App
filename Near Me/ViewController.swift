//
//  ViewController.swift
//  Near Me
//
//  Created by Raj Shah on 15/07/17.
//  Copyright © 2017 Raj Shah. All rights reserved
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var placeIconCollectionView: UICollectionView!
    let placeTypeArray: [String] = ["ATM",
        "Bank",
        "Cafe",
        "Hospital",
        "Hotel",
        "Library",
        "Mall",
        "Medical Store",
        "Restaurent",
        "School",
    ]
    let types: [String] = ["atm",
        "bank",
        "cafe",
        "hospital",
        "hotel",
        "library",
        "shopping_mall",
        "pharmacy",
        "restaurant",
        "school"
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        placeIconCollectionView.register(UINib.init(nibName: "PlaceListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "segueMenuToTabBar"){
            let decVC = segue.destination as! PlacesTabBar
            decVC.placeType = types[(sender as! IndexPath).row]
        }
    }
}
//segueMenuToTabBar
extension ViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return placeTypeArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : PlaceListCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PlaceListCollectionViewCell
        cell.placeTypeImageView.image = UIImage.init(named: self.placeTypeArray[indexPath.row])
        cell.placeTypeLbl.text = self.placeTypeArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.size.width - 20) / 3 - 10, height: ((UIScreen.main.bounds.size.width - 20) / 3 - 10) * 6 / 5)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        return 15
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "segueMenuToTabBar", sender: indexPath)
    }

}
