//
//  PlantDetailsViewController.swift
//  GoldenLeaf
//
//  Created by maram  on 22/06/1444 AH.
//

import UIKit

class PlantDetailsViewController: UIViewController {

    var plant : PlantElement?
    
    @IBOutlet weak var plantimg: UIImageView!
    @IBOutlet weak var plantname: UILabel!
    @IBOutlet weak var detailes: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        if plant != nil {
            setplant()
        }
    }
   
    
    
    @IBAction func threeDButton(_ sender: Any) {
    }
    
    @IBAction func AddToCart(_ sender: Any) {
        if let plant = plant {
            Cart.shared.items.append(plant)
        }
        self.dismiss(animated: true) {
            
        }
        
    }
    
    
    func getplant(_ plant:  PlantElement?){
        self.plant = plant
    }
    
    func setplant(){
        let img = URL(string: plant!.img!)!
        
        self.plantimg.kf.setImage(with: img)
        self.plantimg.Rouned200()
        self.plantname.text = "Name: \(plant!.latinName!)"
        self.detailes.text = "Detailes :- \n  🌱 Plant prefume : \(plant!.perfume ?? nil) \n  🌱 Color of the blooms:\(plant!.colorOfBlooms ?? nil) \n 🌱 Color of the leaf :\(plant!.colorOfLeaf!) \n 🌱 Watering: \(plant!.watering!) \n "
        
        
//        \(plant?.lightIdeal!)  plant prefume : \(plant?.perfume!) Color of the blooms :\(plant?.colorOfBlooms!) Color of the leaf :\(plant?.colorOfLeaf!)"
    }
}
