//
//  SecondViewController.swift
//  Localized App 1
//
//  Created by Muhammad Waleed on 08.12.23.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var detailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateLabel()
    }
    
    func updateLabel() {
        // localize the detail value based on the selected language
        if let selectedLanguage = UserDefaults.standard.string(forKey: "selectedLanguage") {
            detailLabel.text = "This is detail label".localize(in: selectedLanguage)
        } else {
            // Use a default language if none is selected
            detailLabel.text = "This is detail label".localize(in: "en")
        }
    }
}

