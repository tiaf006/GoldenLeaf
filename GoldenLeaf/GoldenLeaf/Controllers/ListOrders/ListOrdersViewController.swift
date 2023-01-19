//
//  ListOrdersViewController.swift
//  GoldenLeaf
//
//  Created by elham on 1/15/23.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseDatabase


class ListOrdersViewController: UIViewController {
    var ref: DatabaseReference!
    
    struct Order {
        let date: String?
    }
    //MARK: Outlet
    @IBOutlet weak var tableView: UITableView!
  
    
    //MARK: Var
    var orders : [Order] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        //title = "Orders"
        // registerCell()
        // Do any additional setup after loading the view.
        ref = Database.database().reference().child("Cards");
        ref.observe(DataEventType.value, with:{(snapshot) in
            if snapshot.childrenCount>0{
                self.orders.removeAll()
         
                for orders in snapshot.children.allObjects as![DataSnapshot] {
                let orderObject = orders.value as? [String: AnyObject]
                let orderDate = orderObject?["order date & time"]
                let order = Order(date: orderDate as! String?)
                self.orders.append(order)
            }
            self.tableView.reloadData()
            }
        })
    }
    
    
    //    private func registerCell() {
    //
    //        tableView.register(UINib(nibName: ProductTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ProductTableViewCell.identifier)
    //
    //    }
}


extension ListOrdersViewController: UITableViewDataSource , UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListOrderTableViewCell
        cell.dateLabel.text = orders[indexPath.row].date
        
        return cell
    }
}

