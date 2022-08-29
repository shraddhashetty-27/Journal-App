//
//  EntryViewController.swift
//  JournalApp
//
//  Created by Shraddha Shetty on 8/10/22.
//  Copyright © 2022 Shraddha Shetty. All rights reserved.
//

import UIKit

class EntryViewController: UIViewController , UITextViewDelegate{

    @IBOutlet weak var bbutton: UIButton!
    @IBOutlet weak var buttomConstraint: NSLayoutConstraint!
    @IBOutlet weak var entryTextView: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var entry : Entry?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bbutton.layer.cornerRadius=8
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        if entry == nil{
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext{
                entry = Entry(context:context)
                entry?.date = datePicker.date
                entry?.text = "Welcome to Daily Journal...."
                entryTextView.becomeFirstResponder()
            }
        }
    
        entryTextView.text=entry?.text
        if let dateToeShown = entry!.date{
            datePicker.date=dateToeShown
        }
        entryTextView.delegate=self
    }
    @IBAction func deleteTapped(_ sender: Any) {
        if entry != nil{
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext{
                context.delete(entry!)
                try? context.save
            }
        }
        navigationController?.popViewController(animated: true)
    }

    
    override func viewWillDisappear(_ animated: Bool) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            buttomConstraint.constant=keyboardHeight
        }
    }
    @IBAction func datePicoerChanged(_ sender: Any) {
        entry?.date=datePicker.date
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    func textViewDidChange(_ textView: UITextView) {
        entry?.text = entryTextView.text
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    

}
