//
//  detailsViewController.swift
//  toDo Swift Version
//
//  Created by Zoe Tse on 13/7/19.
//  Copyright © 2019 Zoe Tse. All rights reserved.
//

import UIKit

class detailsViewController: UIViewController {
    
    @IBOutlet weak var item: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imageImageView: UIImageView!
    @IBOutlet weak var descriptor: UILabel!
    @IBOutlet weak var doneOrNot: UILabel!
    @IBOutlet weak var markDoneSwitch: UISwitch!
    
    var doneOrNotDone = false
    var todo: contentsToDos?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        markDoneSwitch.addTarget(self, action: #selector(switchStateDidChange(_:)), for: .valueChanged)
        
        item.text = "Item: \(todo?.item ?? "")"
        
        guard let date = todo?.date else {return}
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        let formattedDate = format.string(from: date)
        dateLabel.text = "Due date: " + formattedDate
        
        imageImageView.image = todo?.image
        
        descriptor.text = "Description: \(todo?.description ?? "")"
        
        if todo!.doneOrNot == true {
            doneOrNot.text = "Done status: \(todo!.doneOrNot)"
            markDoneSwitch.setOn(true, animated: true)
        }
        
        else {
            doneOrNot.text = "Done status: \(todo!.doneOrNot)"
            markDoneSwitch.setOn(false, animated: true)
        }

        // Do any additional setup after loading the view.
    }
    
    @objc func switchStateDidChange (_ sender: UISwitch){
        if markDoneSwitch.isOn == true {
            doneOrNotDone = false
            todo?.doneOrNot = false
            doneOrNot.text = "Done status: \(todo!.doneOrNot)"
            markDoneSwitch.setOn(doneOrNotDone, animated: true)
        }
        
        else {
            doneOrNotDone = true
            todo?.doneOrNot = true
            doneOrNot.text = "Done status: \(todo!.doneOrNot)"
            markDoneSwitch.setOn(doneOrNotDone, animated: true)
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addOrEdit",
            let navController = segue.destination as? UINavigationController,
            let destVC = navController.viewControllers.first as? EditTableViewController {
            destVC.todo = todo
        }
    }
}
