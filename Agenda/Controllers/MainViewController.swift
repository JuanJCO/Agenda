//
//  MainViewController.swift
//  Agenda
//
//  Created by Jazz on 7/3/21.
//

import Foundation
import UIKit

class MainViewController: UIViewController{

    static var shared: MainViewController = MainViewController()
    
    var nameText: String = ""
    var phoneText: String = ""
    var nameArray: [String] = ["Test1"]
    var phoneArray: [String] = ["Test1"]
    
    @IBOutlet weak var tv: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tv.reloadData()
        
        if (Data.shared.nameArray.isEmpty){
            print ("No tiene datos")
        } else{
            
            print("Tiene (count): ", Data.shared.nameArray.count)
            print("Puede tener (capacity): ", Data.shared.nameArray.capacity)
            print(Data.shared.nameArray)
            print(Data.shared.phoneArray)
        }
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Data.shared.nameArray.count
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ContactCell
 
        cell.labelCell.text = Data.shared.nameArray[indexPath.row]
        cell.numberLabelCell.text = Data.shared.phoneArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Data.shared.row = indexPath.row
    }
}





