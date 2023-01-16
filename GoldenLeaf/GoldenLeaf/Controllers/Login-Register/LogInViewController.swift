//
//  LogInViewController.swift
//  GoldenLeaf

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn
import FirebaseStorage

class LogInViewController: UIViewController {
    
    
    //IBOutlet
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    //    @IBOutlet weak var gmailButton: GIDSignInButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //LogIn button style
        logInButton.layer.cornerRadius = logInButton.frame.height / 2
        logInButton.layer.borderWidth = 2
        logInButton.backgroundColor = .systemBlue
        logInButton.layer.borderColor = UIColor.white.cgColor
        
    }
    
    
    @IBAction func logInAction(_ sender: Any) {
        guard
            let email = emailTextField.text, !email.isEmpty,
            let password = passwordTextField.text, !password.isEmpty else {
            // Check if any requairment information is empty will show error message
            let alertController = UIAlertController(title: "Error", message: "Please fill all the information", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .cancel)
            alertController.addAction(okAction)
            self.present(alertController, animated: true)
            return
        }
        
        if !emailTextField.isEmail(){
            // Check if email is not match email format will show error message
            let alertController = UIAlertController(title: "Error", message: "Please enter correct email", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .cancel)
            alertController.addAction(okAction)
            self.present(alertController, animated: true)
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error{
                // Check if password is wrong will show error message, else will get the user online
                let alertController = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .cancel)
                alertController.addAction(okAction)
                self.present(alertController, animated: true)
                //                print("\(error.localizedDescription)")
                //                return
            }else{
                
                let plantsCollictionVC = self.storyboard?.instantiateViewController(withIdentifier: "PlantsCollictionViewController") as! PlantsCollictionViewController
                self.present(plantsCollictionVC, animated: true)
                
            } // End else
        }
    } // End logInAction
    
    
    @IBAction func gmailAction(_ sender: Any) {
        guard let clientID = FirebaseApp.app()?.options.clientID else {return}
        
        let config = GIDConfiguration(clientID: clientID)
        
        
        GIDSignIn.sharedInstance.configuration = config
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult , error in
            if error != nil {
                let alertController = UIAlertController(title: "Error", message: "\(error!.localizedDescription)", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .cancel)
                alertController.addAction(okAction)
                self.present(alertController, animated: true)
            }
            let firstName = signInResult?.user.profile!.givenName!
            let lastName = signInResult?.user.profile!.familyName!
            let email = signInResult?.user.profile!.email
            let image = signInResult?.user.profile!.imageURL(withDimension: 300)
            
            guard let idToken = signInResult?.user.idToken else { return }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString, accessToken: (signInResult?.user.accessToken.tokenString)!)
            
            Auth.auth().signIn(with: credential) { authResult, error in
                if error != nil {
                    let alertController = UIAlertController(title: "Error", message: "\(error!.localizedDescription)", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Ok", style: .cancel)
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true)
                }
                
                        if let  imageURL = URL(string: "\(image!)") {
                            URLSession.shared.dataTask(with: imageURL) { data, response, error in
                                DispatchQueue.main.async {
                                    let path = "images/\(authResult!.user.uid).jpg"
                                    let storageReference : StorageReference!
                                    storageReference = Storage.storage().reference().child(path)
                                    storageReference.putData(data!)
                                }
                            }.resume()
                        }
                
                let reference = Database.database().reference(fromURL: "https://golden-leaf-5afdf-default-rtdb.firebaseio.com").child("User").child("\(authResult!.user.uid)")
                let values = ["first name" : firstName,
                              "last name" : lastName,
                              "email" : email]
                
                reference.setValue(values)
                
                // Show PlantsCollictionViewController
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let plantsCollictionVC = storyBoard.instantiateViewController(withIdentifier: "PlantsCollictionViewController") as! PlantsCollictionViewController
                plantsCollictionVC.modalPresentationStyle = .fullScreen
                self.present(plantsCollictionVC, animated: true)
//                plantsCollictionVC.navigationItem.hidesBackButton = true
                
            }
            
        }
        
        
    }
}
