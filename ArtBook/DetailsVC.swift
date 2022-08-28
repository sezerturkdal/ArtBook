//
//  DetaillsVC.swift
//  ArtBook
//
//  Created by Sezer on 8.08.2022.
//

import UIKit
import CoreData

class DetailsVC: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    var chosenPainting=""
    var chosenPaintingId:UUID?

    @IBOutlet weak var txtName: UITextField!
    
  
    @IBOutlet weak var txtYear: UITextField!
    @IBOutlet weak var txtArtist: UITextField!
    @IBOutlet weak var artImage: UIImageView!
    
    override func viewDidLoad() {
        
        if chosenPainting != ""{
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest=NSFetchRequest<NSFetchRequestResult>(entityName: "Images")
            
            let idString = chosenPaintingId?.uuidString
            fetchRequest.predicate=NSPredicate(format: "id = %@", idString!)
            fetchRequest.returnsObjectsAsFaults=false
            
            do{
                let results = try context.fetch(fetchRequest)
                if results.count>0{
                    for result in results as! [NSManagedObject] {
                        if let name = result.value(forKey: "name") as? String{
                            txtName.text = name
                        }
                        if let artist = result.value(forKey: "artist") as? String{
                            txtArtist.text = artist
                        }
                        if let year = result.value(forKey: "year") as? Int{
                            txtYear.text = String(year)
                        }
                        if let imageData = result.value(forKey: "image") as? Data{
                            let image = UIImage(data:imageData)
                            artImage.image=image
                        }
                    }
                }
            }catch{
                print("Error")
            }
            
        }else {
            txtName.text=""
            txtArtist.text=""
            txtYear.text=""
        }
        
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
        let appDelegate=UIApplication.shared.delegate as!AppDelegate
        let context=appDelegate.persistentContainer.viewContext
        
        let newPainting=NSEntityDescription.insertNewObject(forEntityName: "Images", into: context)
        
        newPainting.setValue(txtName.text, forKey: "name")
        
        if let year = Int(txtYear.text!){
            newPainting.setValue(year, forKey: "year")
        }
        newPainting.setValue(txtArtist.text, forKey: "artist")
        newPainting.setValue(UUID(), forKey: "id")
        
        let data = artImage.image!.jpegData(compressionQuality: 0.5)
        
        newPainting.setValue(data, forKey: "image")
        
        do{
            try context.save()
            print("success")
        }
        catch{
            print("error")
        }
        NotificationCenter.default.post(name: NSNotification.Name("newData"), object: nil)
        self.navigationController?.popViewController(animated: true)
    }
    


}
