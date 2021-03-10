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
    
    var currentUser: User?
    
    @IBOutlet weak var tv: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tv.reloadData()
        
        if (NetworkManager.shared.checkUser()){
            self.currentUser = NetworkManager.shared.getUser()
            print(currentUser)
        }
        
        if (AgendaData.shared.nameArray.isEmpty){
            print ("No tiene datos")
        } else{
            
            print("Tiene (count): ", AgendaData.shared.nameArray.count)
            print("Puede tener (capacity): ", AgendaData.shared.nameArray.capacity)
            print(AgendaData.shared.nameArray)
            print(AgendaData.shared.phoneArray)
        }
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AgendaData.shared.nameArray.count
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ContactCell
 
        cell.labelCell.text = AgendaData.shared.nameArray[indexPath.row]
        cell.numberLabelCell.text = AgendaData.shared.phoneArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        AgendaData.shared.row = indexPath.row
    }
}





