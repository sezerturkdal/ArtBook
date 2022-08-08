//
//  DetaillsVC.swift
//  ArtBook
//
//  Created by Sezer on 8.08.2022.
//

import UIKit

class DetailsVC: UIViewController {


    @IBOutlet weak var txtName: UITextField!
    
  
    @IBOutlet weak var txtYear: UITextField!
    @IBOutlet weak var txtArtist: UITextField!
    @IBOutlet weak var artImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        
        view.addGestureRecognizer(gestureRecognizer)
        
        // Do any additional setup after loading the view.
    }
    
    @objc func hideKeyboard(){
            view.endEditing(true)
    }

    @IBAction func SaveClicked(_ sender: Any) {
    }
    


}
