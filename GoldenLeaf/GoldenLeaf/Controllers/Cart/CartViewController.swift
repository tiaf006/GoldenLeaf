//
//  CartViewController.swift
//  GoldenLeaf
//
//  Created by TAIF Al-zahrani on 22/06/1444 AH.
//

import UIKit

class CartViewController: UIViewController {

    //MARK: - Outlet
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var checkoutContainer: UIView!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var checkoutButton: UIButton!
    
    
    //MARK: - var
//    var PlantArray : [PlantElement] = []
    var cart: Cart? = nil
    
    
    //MARK: - lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        registerCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        totalLabel.text = "\(Cart.shared.total)"
        tableView.reloadData()
    }
    
    //MARK: - func register
    private func registerCells() {
        
        tableView.register(UINib.init(nibName: ProductTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ProductTableViewCell.identifier)
    }

    

}// end class


// MARK: - table View Delegate and DataSource

extension CartViewController: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Cart.shared.items.count
        //PlantArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.identifier) as! ProductTableViewCell
        cell.plantItem = Cart.shared.items[indexPath.row]
        cell.setup()
        
            return cell
    }
    
    // delet
//    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//
//        let deletAction = UIContextualAction (style: .destructive, title: "Delet") { (action , view , completionHandler) in
//           // self.tasks.remove(at: indexPath.row )
//            tableView.beginUpdates()
//            tableView.deleteRows(at: [indexPath], with: .automatic)
//            tableView.endUpdates()
//
//            completionHandler(true)
//        }
//        return UISwipeActionsConfiguration (actions: [deletAction])
//    }
 
    
}
extension CartViewController: CartItemDelegate {

    
    // MARK: - CartItemDelegate
    func updateCartItem(cell: ProductTableViewCell, quantity: Int) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
//        guard let cartItem = Cart.shared.items[indexPath.row] else { return }
        let cartItem = Cart.shared.items[indexPath.row]
        //Update cart item quantity
//        cartItem.quantity = quantity

        //Update displayed cart total
//        guard let total = Cart.shared.total else { return }
        let total = Cart.shared.total
        print("Cart", indexPath, cartItem, total)
//        totalLabel.text = currencyHelper.display(total: total)
    }
}

protocol CartItemDelegate {
    func updateCartItem(cell: ProductTableViewCell, quantity: Int)
}

class Cart {
    static var shared: Cart = Cart.init()
    var items: [PlantElement] = []
    var total : Double {
        var price: Double = 0
        let _ = items.map { plant in
            price += Double(plant.heightAtPurchase?.cm ?? 0)
            return
        }
        return price 
    }
}
