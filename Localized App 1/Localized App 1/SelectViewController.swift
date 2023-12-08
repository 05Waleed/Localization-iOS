//
//  SelectViewController.swift
//  Localized App 1
//
//  Created by Muhammad Waleed on 06.12.23.
//

import UIKit

class SelectViewController: UIViewController {

    var languageArray = [("English", "en"), ("Spanish", "es"), ("German", "de"), ("Arabic", "ar")]

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var languagePicker: UIPickerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabels()
        loadSelectedLanguage()
    }
    
    func loadSelectedLanguage() {
        // Load the selected language from UserDefaults
        if let savedLanguage = UserDefaults.standard.string(forKey: "selectedLanguage") {
            if let index = languageArray.firstIndex(where: { $0.1 == savedLanguage }) {
                languagePicker.selectRow(index, inComponent: 0, animated: false)
                updateLabelsForSelectedLanguage()
            }
        }
    }

    func setupLabels() {
        // Set the initial labels based on the selected language
        let selectedLanguage = languageArray[languagePicker.selectedRow(inComponent: 0)]
        updateLabels(selectedLanguage)
        
        headingLabel.backgroundColor = .clear
        descriptionLabel.backgroundColor = .clear
    }

    func updateLabelsForSelectedLanguage() {
        // Get the selected language
        let selectedLanguage = languageArray[languagePicker.selectedRow(inComponent: 0)]
        updateLabels(selectedLanguage)

        // Save the selected language to UserDefaults
        UserDefaults.standard.set(selectedLanguage.1, forKey: "selectedLanguage")
    }

    func updateLabels(_ selectedLanguage: (String, String)) {
        headingLabel.text = "Choose language".localize(in: selectedLanguage.1)
        descriptionLabel.text = "Hello, my name is Waleed, I'm 22 years old.".localize(in: selectedLanguage.1)
    }
}

extension SelectViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return languageArray.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return languageArray[row].0
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("Selected language is \(languageArray[row])")

        // Update labels when a new language is selected
        updateLabelsForSelectedLanguage()
    }

    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60
    }
}

extension String {
    func localize(in language: String) -> String {
        guard let path = Bundle.main.path(forResource: language, ofType: "lproj") else {
            print("Error: Unable to find path for language '\(language)'")
            return self
        }

        guard let bundle = Bundle(path: path) else {
            print("Error: Unable to create bundle for path '\(path)'")
            return self
        }

        let localizedString = NSLocalizedString(self, tableName: "Localizable", bundle: bundle, value: self, comment: self)
        print("Localized '\(self)' in language '\(language)': \(localizedString)")

        return localizedString
    }
}
