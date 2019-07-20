//
//  ViewController.swift
//  toDo Swift Version
//
//  Created by Zoe Tse on 13/7/19.
//  Copyright © 2019 Zoe Tse. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var NameText: UITextField!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    var inputName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imageView.image = UIImage(named: "heehee.jpg")
        self.NameText.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func onStart(_ sender: Any) {
        inputName = NameText.text ?? ""
        performSegue(withIdentifier: "toToDo", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toToDo",
            let navController = segue.destination as?  UINavigationController,
            let nvc = navController.viewControllers.first as? listOfToDosTableViewController {
            nvc.receivedName = inputName
        }
    }

}



