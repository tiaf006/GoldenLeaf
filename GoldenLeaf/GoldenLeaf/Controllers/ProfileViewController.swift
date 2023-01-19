//
//  ProfileViewController.swift
//  GoldenLeaf
//
//  Created by TAIF Al-zahrani on 22/06/1444 AH.
//

import UIKit
import Firebase
import FirebaseAuth

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.profileImg.Rouned()
        // Do any additional setup after loading the view.
    }
    func fetchUserData(){
        let ref = Database.database().reference(fromURL: "https://golden-leaf-5afdf-default-rtdb.firebaseio.com").child("User").child("\(Auth.auth().currentUser!.uid)")
        ref.child("User").child("\(Auth.auth().currentUser!.uid)").observeSingleEvent(of: .value, with: { snapshot in
            // Get user value
            let value = snapshot.value as? NSDictionary
            self.nameLbl.text = value?["username"] as? String ?? ""
            
            // ...
            
        })
    }

    @IBAction func goToLocationPage(_ sender: Any) {
    }
    
    @IBAction func logout(_ sender: Any) {
     }
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
