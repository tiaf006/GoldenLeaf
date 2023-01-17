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
    var PlantArray : [PlantElement] = []
   // var cart: Cart? = nil
    
    
    //MARK: - lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        registerCells()
    }
    
    
    
    //MARK: - func register
    private func registerCells() {
        tableView.register(UINib(nibName: ProductTableViewCell.identifier, bundle: nil), forHeaderFooterViewReuseIdentifier: ProductTableViewCell.identifier)
    }

    

}// end class


// MARK: - table View Delegate and DataSource

extension CartViewController: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
        //PlantArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.identifier) as! ProductTableViewCell
      //  cell.setup(name:name[indexpath.row])
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
//extension CartViewController: CartItemDelegate {
//    // MARK: - CartItemDelegate
//    func updateCartItem(cell: ProductTableViewCell, quantity: Int) {
//        guard let indexPath = tableView.indexPath(for: cell) else { return }
//        guard let cartItem = cart?.items[indexPath.row] else { return }
//
//        //Update cart item quantity
//        cartItem.quantity = quantity
//
//        //Update displayed cart total
//        guard let total = cart?.total else { return }
//        totalLabel.text = currencyHelper.display(total: total)
//    }
//}
