//
//  DetaillsVC.swift
//  ArtBook
//
//  Created by Sezer on 8.08.2022.
//

import UIKit

class DetailsVC: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate{


    @IBOutlet weak var txtName: UITextField!
    
  
    @IBOutlet weak var txtYear: UITextField!
    @IBOutlet weak var txtArtist: UITextField!
    @IBOutlet weak var artImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Recognizers
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
        
        artImage.isUserInteractionEnabled=true
        let imageTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        artImage.addGestureRecognizer(imageTapRecognizer)
    }
    
    @objc func selectImage(){
        let picker=UIImagePickerController()
        picker.delegate=self
        picker.sourceType = .photoLibrary
        picker.allowsEditing=true
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        artImage.image=info[.editedImage] as? UIImage
        self.dismiss(animated: true) {
            print("imagePicker kapatildi")
        }
    }
    
    @objc func hideKeyboard(){
            view.endEditing(true)
    }

    @IBAction func SaveClicked(_ sender: Any) {
    }
    


}
