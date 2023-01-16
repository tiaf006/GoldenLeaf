//
//  PlantsCollictionViewController.swift
//  GoldenLeaf
//
//  Created by TAIF Al-zahrani on 22/06/1444 AH.
//

import UIKit

class PlantsCollictionViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource {
   

    
    
    @IBOutlet weak var PlantsColliction: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PlantsColliction.delegate = self
        PlantsColliction.dataSource = self
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = UICollectionViewCell()
        return cell
    }
    
    
    
    
   



}

