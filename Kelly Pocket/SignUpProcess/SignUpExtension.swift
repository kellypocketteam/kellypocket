//
//  SignUpExtension.swift
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

extension Date {
    var age: Int {
        return Calendar.current.dateComponents([.year], from: self, to: Date()).year!
    }
}

extension SignUp {
    private func ref() -> DatabaseReference {
        return Database.database().reference()
    }
    
    private func authRef() -> Auth {
        return Auth.auth()
    }
    
    //Checks to make sure that email: is not already in use; isn't blank; is in proper format
    func checkUsername(){
        let tempUser = username.text! // ?? ""
        let databaseRef = Database.database().reference(withPath: "Usernames")
        databaseRef.observeSingleEvent(of: .value, with: { (snapshot) in
            let errorFlag = snapshot.hasChild(tempUser)
            print(snapshot.hasChild(tempUser))
            print(errorFlag)
            print("Hello!!")
            if (errorFlag == true) {
                self.usernameLabel.text = "Username is already in use"
            } else {
                self.checkPassword(usernameIn: tempUser)
            }
        })
    }
    
    //Function that checks if password entered was then confirmed or isn't blank
    func checkPassword(usernameIn: String!) {
        self.userName = usernameIn
        print(self.userName)
        let userPass = self.password.text!
        let userPassCon = self.confirmPassword.text!
        if (userPass != userPassCon) {
            self.passwordLabel.text = "Passwords do not match!"
        } else if (userPass == "" || userPassCon == "") {
            self.passwordLabel.text = "Please enter a password"
        } else if(userPass.characters.count < 6 || userPass.characters.count > 18) {
            self.passwordLabel.text = "Password must be between 6 and 18 characters"
        } else {
            userpassword = self.password.text!
            spinner.stopAnimating()
            let vc = self.storyboard!.instantiateViewController(withIdentifier: "Sign Up Part 2") as! SignUp2
            vc.usernameR = username.text!
            vc.passwordR = password.text!
            self.present(vc, animated: true, completion: nil)
        }
    }
}

/*"
 "(!data.exists() || data.val() === root.child('users/' + auth.uid + '/username').val()) && newData.exists()",
 ".validate": "newData.isString() && newData.val() === root.child('users/' + auth.uid + '/username').val()"
 
 
 (!data.exists() || data.val() === root.child('users/' + auth.uid + '/username').val()) && newData.exists()",
 ".validate": "newData.isString() && newData.val() === root.child('users/' + auth.uid + '/username').val()"*/

/*let databaseRef = Database.database().reference()
 self.usersRef = databaseRef.child("Users")
 self.usersRef!.observe(.value, with: { (snapshot) in
 errorFlag = snapshot.hasChild(tempUser)
 print("Hello!!")
 if (errorFlag == true) {
 self.usernameLabel.text = "Username is already in use"
 } else {
 self.userName = tempUser
 errorFlag = false
 }
 })*/
/*.observe(.value, with: { snapshot in
 errorFlag = snapshot.hasChild(tempUser)
 if (errorFlag != nil || errorFlag == true) {
 self.usernameLabel.text = "Username is already in use"
 errorFlag = true
 } else {
 self.userName = tempUser
 errorFlag = false
 }
 })*/


extension SignUp2 {
    func checkInfo() {
        var error = false
        emailLabel.text = ""
        fNLabel.text = ""
        lNLabel.text = ""
        if(email.text! == "") {
            emailLabel.text = "Please enter an email"
            error = true
        } else if (firstName.text! == "") {
            fNLabel.text = "Please enter your first name"
            error = true
        } else if (lastName.text! == "") {
            lNLabel.text = "Please enter your last name"
            error = true
        }
        if(!error) {
            let vc = self.storyboard!.instantiateViewController(withIdentifier: "Sign Up Part 3") as! SignUp3
            vc.usernameR = usernameR!
            vc.passwordR = passwordR!
            vc.emailR = email.text!
            vc.fnR = firstName.text!
            vc.lnR = lastName.text!
            self.present(vc, animated: true, completion: nil)
        }
    }
}

extension SignUp3 {
    func checkAge() {
        var error = false
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        let userBDay = formatter.date(from: self.dOB.text!) //Use Try Catch here
        let userAge = userBDay?.age
        if(userAge! < 18) {
            error = true
            self.dOBLabel.text = "Sorry! You need to be 18+ to use this app!"
        } else if (userAge! > 100) {
            error = true
            self.dOBLabel.text = "Please enter a valid date"
        }
        if(!error) {
            let vc = self.storyboard!.instantiateViewController(withIdentifier: "Sign Up Part 4") as! SignUp4
            vc.usernameR = usernameR!
            vc.passwordR = passwordR!
            vc.emailR = emailR!
            vc.fnR = fnR!
            vc.lnR = lnR!
            vc.dOBR = dOB.text!
            self.present(vc, animated: true, completion: nil)
        }
    }
}

extension SignUp4 {
    
    func checkLocation() {
        print("1")
        zipLabel.text = ""
        print("2")
        let geocoder = CLGeocoder()
        print("3")
        geocoder.geocodeAddressString(zipcode.text!) { (placemarks, error) -> Void in
            // Placemarks is an optional array of CLPlacemarks, first item in array is best guess of Address
            if let placemark = placemarks?[0] {
                print("4")
                let ac = UIAlertController(title: "Confirmation", message: "Is \(placemark.locality!), \(placemark.administrativeArea!) correct?", preferredStyle: .alert)
                print("5")
                let yes = UIAlertAction(title: "Yes", style: .default) { (action) in
                    let vc = self.storyboard!.instantiateViewController(withIdentifier: "Review") as! Review
                    vc.usernameR = self.usernameR!
                    vc.passwordR = self.passwordR!
                    vc.emailR = self.emailR!
                    vc.fnR = self.fnR!
                    vc.lnR = self.lnR!
                    vc.dOBR = self.dOBR!
                    vc.zipR = self.zipcode.text!
                    self.present(vc, animated: true, completion: nil)
                }
                print("6")
                let no = UIAlertAction(title: "No", style: .cancel) { (action) in
                    self.zipcode.text! = ""
                }
                print("7")
                ac.addAction(yes)
                ac.addAction(no)
                print("8")
                self.present(ac, animated: true, completion: nil)
                print(placemark.locality!)
                print(placemark.administrativeArea!)
            } else {
                self.zipLabel.text = "Please enter a valid zipcode"
            }
        }
        
    }
}

extension Review {
    private func ref() -> DatabaseReference {
        return Database.database().reference()
    }
    
    private func authRef() -> Auth {
        return Auth.auth()
    }
    
    func createUser () {
        authRef().createUser(withEmail: email.text!, password: passwordR!) { (user, error) in
            let userid = user?.uid
            if(error == nil) {
                let values = ["Email": self.email.text!, "Username": self.username.text!, "First Name": self.firstName.text!, "Last Name": self.lastName.text!, "dOB": self.dOB.text!, "Zipcode": self.zipcode.text!]
                self.saveUserInfo(values: values, uid: userid!)
                let vc = self.storyboard!.instantiateViewController(withIdentifier: "Log In")
                self.present(vc, animated: true, completion: nil)
            } else if (error != nil) {
                let ac = UIAlertController(title: "Error", message: error!.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                ac.addAction(cancel)
                self.present(ac, animated: true, completion: nil)
            }
        }
    }
    
    func saveUserInfo (values: [String: String], uid: String) {
        ref().child("Users").child(uid).setValue(values) { (error, ref) in
            if(error != nil) {
                let ac = UIAlertController(title: "Error", message: error!.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                ac.addAction(cancel)
                self.present(ac, animated: true, completion: nil)
            } else if(error == nil) {
                self.saveUsername(userIn: self.username.text!)
            }
        }
    }
    
    func saveUsername (userIn: String) {
        ref().child("Usernames").child(userIn).setValue([userIn: userIn])
    }
}
