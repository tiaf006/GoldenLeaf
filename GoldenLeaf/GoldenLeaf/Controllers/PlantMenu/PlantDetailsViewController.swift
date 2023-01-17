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
    }
   
    
    
    @IBAction func threeDButton(_ sender: Any) {
    }
    
    @IBAction func AddToCart(_ sender: Any) {
    }
    
    
    func getplant(_ plant:  PlantElement?){
        self.plant = plant
    }
    
    func setplant(){
//        var imgs = URL(string: plant!.img!)!
//        self.plantimg.kf.setImage(with: img)
        self.plantname.text = "Name: \(plant!.latinName!)"
        self.detailes.text = "\(plant!.lightTolered!)"
        
        
//        \(plant?.lightIdeal!)  plant prefume : \(plant?.perfume!) Color of the blooms :\(plant?.colorOfBlooms!) Color of the leaf :\(plant?.colorOfLeaf!)"
    }
}
