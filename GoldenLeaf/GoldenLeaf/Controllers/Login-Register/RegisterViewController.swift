//
//  RegisterViewController.swift
//  GoldenLeaf


import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage

class RegisterViewController: UIViewController {

    //IBOutlet
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var rePasswordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var userImage: UIImageView!
    
    //MARK: vars
    var imageData = Data()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Signup button style
        signUpButton.layer.cornerRadius = signUpButton.frame.height / 2
        signUpButton.layer.borderWidth = 2
        signUpButton.backgroundColor = .systemBlue
        signUpButton.layer.borderColor = UIColor.white.cgColor
        
        //ImagePicker
        userImage.layer.cornerRadius = 150.0/2.0
        userImage.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapChangeProfileImage))
        gesture.numberOfTouchesRequired = 1
        gesture.numberOfTapsRequired = 1
        userImage.addGestureRecognizer(gesture)
        
    }
    
    @objc private func didTapChangeProfileImage() {
        presentPhotoActionSheet()
    }
    
    
    @IBAction func signUpAction(_ sender: Any) {
        guard
            // Check if any requairment information is empty will show error message
            let firstName = firstNameTextField.text, !firstName.isEmpty,
            let lastName = lastNameTextField.text, !lastName.isEmpty,
            let email = emailTextField.text, !email.isEmpty,
            let password = passwordTextField.text, !password.isEmpty,
            let rePassword = rePasswordTextField.text, !rePassword.isEmpty else {
            let alertController = UIAlertController(title: "Error", message: "Please fill all the information", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .cancel)
            alertController.addAction(okAction)
            self.present(alertController, animated: true)
            return
        }
        
        // Check if email is not match email format will show error message
        if !emailTextField.isEmail(){
            let alertController = UIAlertController(title: "Error", message: "Please enter correct email", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .cancel)
            alertController.addAction(okAction)
            self.present(alertController, animated: true)
            return
        }
        
        // Check if password is less than 6 digits will show error message
        if password.count < 6 {
            let alertController = UIAlertController(title: "Error", message: "The password must be 6 characters or more", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .cancel)
            alertController.addAction(okAction)
            self.present(alertController, animated: true)
            return
        }
        
        // Check if re-password is not match password will show error message
        if password != rePassword {
            let alertController = UIAlertController(title: "Error", message: "The re-password is not match password", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .cancel)
            alertController.addAction(okAction)
            self.present(alertController, animated: true)
            return
        }
        
        
        Auth.auth().createUser(withEmail: email, password: password, completion: {(authResult, error: Error?) in
            if error != nil {
                // Check if email is already register will show error message, else will create account
                let alertController = UIAlertController(title: "Error", message: "\(error!.localizedDescription)", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .cancel)
                alertController.addAction(okAction)
                self.present(alertController, animated: true)
                return
            }else{
                // Save the new user into realtime database
                let reference = Database.database().reference(fromURL: "https://golden-leaf-5afdf-default-rtdb.firebaseio.com").child("User").child("\(Auth.auth().currentUser!.uid)")
                let values = ["first name" : firstName,
                              "last name" : lastName,
                              "email" : email]
                
                reference.setValue(values)
                
                
                
                // Show LogInViewController
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let logInVC = storyBoard.instantiateViewController(withIdentifier: "LogInViewController") as! LogInViewController
                logInVC.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(logInVC, animated: true)
                logInVC.navigationItem.hidesBackButton = true
            }
        })
    } // End signUpAction
    
}

//MARK: extention for the emage picker
extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func presentPhotoActionSheet(){
        let actionSheet = UIAlertController(title: "Profile Picture", message: "How would you like to select a picture?", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel",
                                            style: .cancel,
                                            handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Take Photo",
                                            style: .default,
                                            handler: { [weak self]  _ in
            self?.presentCamera()
        }))
        actionSheet.addAction(UIAlertAction(title: "Chose Photo ",
                                            style: .default,
                                            handler: { [weak self] _ in
            self?.presentPhotoPicker()
        }))
        
        present(actionSheet, animated: true)
    }
    
    func presentCamera() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
    }
    
    func presentPhotoPicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
    }
    
    //MARK: - Image picker methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        
        self.userImage.image = selectedImage
        
        let storageRef = Storage.storage().reference()
        imageData = selectedImage.jpegData(compressionQuality: 0.8)!
        
        guard let uid = Auth.auth().currentUser?.uid else{
            return
        }
        
        guard imageData != nil else{
            return
        }
        
        let path = "images/\(uid).jpg"
        let fileRef = storageRef.child(path)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        picker.dismiss(animated: true, completion: nil)
    }
}

