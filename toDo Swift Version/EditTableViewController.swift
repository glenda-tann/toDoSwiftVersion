//
//  EditTableViewController.swift
//  toDo Swift Version
//
//  Created by glendatan on 18/7/19.
//  Copyright © 2019 Zoe Tse. All rights reserved.
//

import UIKit

class EditTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var todo: contentsToDos!
    var needNewToDo = true
    
    @IBOutlet weak var itemField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var descriptionField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var uploadButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if todo != nil {
            itemField.text = todo.item
            datePicker.date = todo.date
            descriptionField.text = todo.description
            imageView.image = todo.image
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped))
        tableView.addGestureRecognizer(tap)
    }
    
    @objc func tapped() {
        print("Tap tap tap")
        view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindSave" {
            let item = itemField.text ?? ""
            let date = datePicker.date
            let description = descriptionField.text ?? ""
            let image = imageView.image
            
            if todo == nil {
                todo = contentsToDos(item: item, description: description, date: date, category: " ", doneOrNot: false, image: image)
            }
            
            else {
                todo.item = item
                todo.description = description
                todo.date = date
                todo.image = image
                needNewToDo = false
            }
        }
    }
    
    @IBAction func uploadButtonPressed(_ sender: Any) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        self.present(pickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    }
}
