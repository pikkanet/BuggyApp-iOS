//
//  ThirdViewController.swift
//  BuggyApp
//
//  Created by Teerawat Vanasapdamrong on 28/6/19.
//  Copyright © 2019 scbeasy. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var mNameTextField:UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mNameTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    @IBAction func onTextChanged(_ sender: Any) {
        print("change")
        self.performSegue(withIdentifier: "next", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "next" {
            let targetVC = segue.destination as! ThirdDetailViewController
            print(self.mNameTextField.text)
            targetVC.message = self.mNameTextField.text
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        print("GG")
        //textField code
        
        textField.resignFirstResponder()  //if desired
        performAction()
        return true
    }
    
    func performAction() {
        //action events
        print("GG")
    }
    
}
