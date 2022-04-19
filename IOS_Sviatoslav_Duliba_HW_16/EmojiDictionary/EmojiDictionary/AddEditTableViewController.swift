//
//  AddEditTableViewController.swift
//  EmojiDictionary
//
//  Created by Duliba Sviatoslav on 22.02.2022.
//

import UIKit

class AddEditTableViewController: UITableViewController {
    
    //MARK: - Properties
    var emoji: Emoji?
    
    //MARK: - Outlets
    @IBOutlet var symbolTextField: UITextField!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var dwscriptionTextField: UITextField!
    @IBOutlet var usageTextField: UITextField!
    @IBOutlet var saveButton: UIBarButtonItem!
    
    //MARK: - Initialization
    init?(coder: NSCoder, emoji: Emoji?) {
        self.emoji = emoji
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateSaveButtonState()
        
        if let emoji = emoji {
            symbolTextField.text = emoji.symbol
            nameTextField.text = emoji.name
            dwscriptionTextField.text = emoji.description
            usageTextField.text = emoji.usage
            title = "Edit Emoji"
        } else {
            title = "Edit Emoji"
        }
    }

    //MARK: - Methods
    func updateSaveButtonState() {
        let nameText = nameTextField.text ?? ""
        let descriptionText = dwscriptionTextField.text ?? ""
        let usageText = usageTextField.text ?? ""
        saveButton.isEnabled = containsSingleEmoji(symbolTextField) &&
           !nameText.isEmpty && !descriptionText.isEmpty &&
           !usageText.isEmpty
    }

    func containsSingleEmoji(_ textField: UITextField) -> Bool {
        guard let text = textField.text, text.count == 1 else {
            return false
        }
        let isCombinedIntoEmoji = text.unicodeScalars.count > 1 && text.unicodeScalars.first?.properties.isEmoji ?? false
        let isEmojiPresentation = text.unicodeScalars.first?.properties.isEmojiPresentation ?? false
        
        return isEmojiPresentation || isCombinedIntoEmoji
    }
    
    override func prepare(for segue: UIStoryboardSegue,
       sender: Any?) {
        guard segue.identifier == "saveUnwind" else { return }
        let symbol = symbolTextField.text!
        let name = nameTextField.text ?? ""
        let description = dwscriptionTextField.text ?? ""
        let usage = usageTextField.text ?? ""
        emoji = Emoji(symbol: symbol, name: name, description: description, usage: usage)
    }
    
    //MARK: - Actions
    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }

}
