//
//  ViewController.swift
//  ArtBook
//
//  Created by Sezer on 8.08.2022.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var tbl_arts: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem=UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
        // Do any additional setup after loading the view.
    }
    
    @objc func addButtonClicked(){
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }


}

