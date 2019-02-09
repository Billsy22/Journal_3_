//
//  EntryDetailViewController.swift
//  Journal_3_
//
//  Created by Taylor Bills on 2/9/19.
//  Copyright © 2019 Taylor Bills. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {

    // MARK: -  Properties
    var entry: Entry?
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    // MARK: -  Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    // MARK: -  Update Views
    func updateViews() {
        if entry != nil {
            self.titleTextField.text = entry!.title
            self.bodyTextView.text = entry!.body
        }
    }
}
