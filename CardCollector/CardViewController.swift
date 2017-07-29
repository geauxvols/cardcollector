//
//  CardViewController.swift
//  CardCollector
//
//  Created by David Maples on 7/25/17.
//  Copyright © 2017 daveapps. All rights reserved.
//

import UIKit

class CardViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var cardImageView: UIImageView!
    
    @IBOutlet weak var cardTitleTextField: UITextField!
    
    @IBOutlet weak var conditionTextField: UITextField!
    
    @IBOutlet weak var priceTextField: UITextField!
    
    var imagePicker = UIImagePickerController()
    
    var card : Card? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        
        if card != nil {
            cardImageView.image = UIImage(data: card!.photo! as Data)
            cardTitleTextField.text = card!.title
            conditionTextField.text = card!.condition
            priceTextField.text = card!.price
        }

    }
    
    
    @IBAction func cardsTapped(_ sender: Any) {
        
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        cardImageView.image = image
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
    }
    
    @IBAction func addTapped(_ sender: Any) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let card = Card(context:context)
        card.title = cardTitleTextField.text
        card.price = priceTextField.text
        card.condition = conditionTextField.text
        card.photo = UIImagePNGRepresentation(cardImageView.image!)! as NSData
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
        
    }
    
}
