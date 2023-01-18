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
    var userSelectPlant: PlantElement?
    @IBOutlet weak var PlantsColliction: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PlantsColliction.delegate = self
        PlantsColliction.dataSource = self
        do {
                if let bundlePath = Bundle.main.path(forResource: "plantsData",ofType: "json"),
                    let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                    let decodedData = try JSONDecoder().decode([PlantElement].self,from: jsonData)
                    self.PlantArray = decodedData
                    //print(PlantArray)
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
        cell.price.text = "\(PlantArray[indexPath.row].heightAtPurchase!.cm!)$"
        cell.backgroundColor = #colorLiteral(red: 0.3288042247, green: 0.7145963907, blue: 0.6151889563, alpha: 1)
        return cell
    }
    
    
    
    @objc func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCell : PlantCell = PlantsColliction.cellForItem(at: indexPath)! as! PlantCell
        // Save user selection
        self.userSelectPlant = PlantArray[indexPath.row]
        performSegue(withIdentifier: "shoPlant", sender: indexPath)
    }
   

        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "shoPlant"{
               let indexpath = sender as! NSIndexPath
    
                let infoplant = segue.destination as! PlantDetailsViewController
                infoplant.plant = userSelectPlant
            }
        }


}

