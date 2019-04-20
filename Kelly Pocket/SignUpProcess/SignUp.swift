//
//  SignUp.swift
//  Kelly Pocket
//
//  Created by Ed Basurto on 4/15/19.
//  Copyright © 2019 Ed Basurto. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth
import CoreLocation

class SignUp: UIViewController, UITextFieldDelegate {
    @IBOutlet var username: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var confirmPassword: UITextField!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var passwordLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        username.delegate = self
        password.delegate = self
        username.becomeFirstResponder()
        spinner.hidesWhenStopped = true
    }
    
    var usersRef: DatabaseReference?
    
    var userName: String!
    var userpassword: String!
    
    var error: Bool!
    
    @IBOutlet var spinner: UIActivityIndicatorView!
    
    @IBAction func nextPage() {
        usernameLabel.text = ""
        spinner.startAnimating()
        checkUsername()
        spinner.stopAnimating()
    }
    
    //Retrieves password (for account creation in Review class)
    func getPassword() -> String {
        return userpassword
    }
    
    //Retrieves email (for account creation in Review class)
    func getUsername() -> String{
        return userName
    }
}

class SignUp2: UIViewController, UITextFieldDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.hidesWhenStopped = true
    }
    
    var usernameR: String?
    var passwordR: String?
    
    @IBOutlet var email: UITextField!
    @IBOutlet var firstName: UITextField!
    @IBOutlet var lastName: UITextField!
    
    @IBOutlet var spinner: UIActivityIndicatorView!
    
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var fNLabel: UILabel!
    @IBOutlet var lNLabel: UILabel!
    
    @IBAction func nextPage() {
        spinner.startAnimating()
        checkInfo()
        spinner.stopAnimating()
    }
}

class SignUp3:UIViewController, UITextFieldDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.hidesWhenStopped = true
    }
    
    var usernameR: String?
    var passwordR: String?
    var emailR: String?
    var fnR: String?
    var lnR: String?
    
    @IBOutlet var dOB: UITextField!
    
    @IBOutlet var spinner: UIActivityIndicatorView!
    
    @IBOutlet var dOBLabel: UILabel!
    
    @IBAction func nextPage() {
        spinner.startAnimating()
        checkAge()
        spinner.stopAnimating()
    }
}

class SignUp4: UIViewController, UITextFieldDelegate, CLLocationManagerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        zipcode.becomeFirstResponder()
        spinner.hidesWhenStopped = true
    }
    
    var usernameR: String?
    var passwordR: String?
    var emailR: String?
    var fnR: String?
    var lnR: String?
    var dOBR: String?
    
    var city: String!
    var state: String!
    
    let locationManager = CLLocationManager()
    
    @IBOutlet var zipcode: UITextField!
    
    @IBOutlet var spinner: UIActivityIndicatorView!
    
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var stateLabel: UILabel!
    @IBOutlet var zipLabel: UILabel!
    
    @IBAction func trackLocation() {
        
    }
    
    @IBAction func nextPage() {
        spinner.startAnimating()
        checkLocation()
        spinner.stopAnimating()
    }
}

class Review: UIViewController, UITextFieldDelegate {
    private func ref() -> DatabaseReference {
        return Database.database().reference()
    }
    
    private func authRef() -> Auth {
        return Auth.auth()
    }
    
    
    @IBOutlet var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.email.text = emailR
        self.username.text = usernameR
        self.firstName.text = fnR
        self.lastName.text = lnR
        self.dOB.text = dOBR
        self.zipcode.text = zipR
        spinner.hidesWhenStopped = true
    }
    
    @IBOutlet var email: UITextField!
    @IBOutlet var username: UITextField!
    @IBOutlet var firstName: UITextField!
    @IBOutlet var lastName: UITextField!
    @IBOutlet var dOB: UITextField!
    @IBOutlet var zipcode: UITextField!
    
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var fnLabel: UILabel!
    @IBOutlet var lnLabel: UILabel!
    @IBOutlet var dobLabel: UILabel!
    @IBOutlet var zipLabel: UILabel!
    
    var usernameR: String?
    var passwordR: String?
    var emailR: String?
    var fnR: String?
    var lnR: String?
    var dOBR: String?
    var zipR: String?
    
    @IBAction func finishSignUp() {
        spinner.startAnimating()
        createUser()
        spinner.stopAnimating()
    }
}
