//
//  MainViewController.swift
//  Agenda
//
//  Created by Jazz on 7/3/21.
//

import Foundation
import UIKit

class MainViewController: UIViewController{
    
    var table: UITableView?

    var nameText: String = ""
    var phoneText: String = ""
    var nameArray: [String] = []
    var phoneArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if (nameArray.isEmpty){
            print ("No tiene datos")
            
        } else{
            print("Tiene (count): ", nameArray.count)
            print("Puede tener (capacity): ", nameArray.capacity)
            for nombre in nameArray{
                print(nombre)
            }

        }
        

        // Do any additional setup after loading the view.        
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
        }
     
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ContactCell
     
            for name in nameArray {
                cell.labelCell.text = name
            }

            for phone in phoneArray {
                cell.numberLabelCell.text = phone
            }

            return cell
        }
}


