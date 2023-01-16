//
//  PlantsCollictionViewController.swift
//  GoldenLeaf
//
//  Created by TAIF Al-zahrani on 22/06/1444 AH.
//

import UIKit
import Kingfisher
class PlantsCollictionViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource {
   

    var PlantArray : [PlantElement] = []
    
    @IBOutlet weak var PlantsColliction: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PlantsColliction.delegate = self
        PlantsColliction.dataSource = self
        do {
                if let bundlePath = Bundle.main.path(forResource: "",ofType: "json"),
                    let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                    let decodedData = try JSONDecoder().decode([PlantElement].self,from: jsonData)
                    self.PlantArray = decodedData
                    print([PlantArray])
                }
            } catch {
                print(error)
            }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        PlantArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "plantCell", for: indexPath) as! PlantCell
        cell.plantName.text = PlantArray[indexPath.row].latinName
        let strURL = URL(string:PlantArray[indexPath.row].img!)
        cell.planti.kf.setImage(with: strURL)
        cell.price.text = "\(PlantArray[indexPath.row].heightAtPurchase!.m!)$"

        return cell
    }
    
    
    
    
   



}

