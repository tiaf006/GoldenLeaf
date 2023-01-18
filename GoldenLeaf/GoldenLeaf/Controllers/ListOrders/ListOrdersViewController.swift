//
//  ListOrdersViewController.swift
//  GoldenLeaf
//
//  Created by elham on 1/15/23.
//

import UIKit
import Firebase

class ListOrdersViewController: UIViewController {
    
    
    //MARK: Outlet
    @IBOutlet weak var tableView: UITableView!
  
    
    //MARK: Var
    var date = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        //title = "Orders"
        // registerCell()
        // Do any additional setup after loading the view.
    }
    
    
    //    private func registerCell() {
    //
    //        tableView.register(UINib(nibName: ProductTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ProductTableViewCell.identifier)
    //
    //    }
}


extension ListOrdersViewController: UITableViewDataSource , UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        return cell
    }

//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
    
    
}

