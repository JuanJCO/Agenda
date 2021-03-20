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
    
//    var currentUser: User?
    
    @IBOutlet weak var tv: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NetworkManager.shared.showContacts(completionHandler: {
            contacts in
            
            ContactClass.shared.contactsArray = contacts

            print("ContactClass", ContactClass.shared.contactsArray)
            
            self.tv.reloadData()
        })
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ContactClass.shared.contactsArray.count
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ContactCell
        cell.labelCell.text = ContactClass.shared.contactsArray[indexPath.row].name
        cell.numberLabelCell.text = ContactClass.shared.contactsArray[indexPath.row].phone
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        AgendaData.shared.row = indexPath.row
    }
    
}





