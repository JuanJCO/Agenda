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
    
    override func viewDidAppear(_ animated: Bool) {
        tv.reloadData()
        
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AgendaData.shared.currentUser.contacts.count
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ContactCell
        cell.labelCell.text = AgendaData.shared.currentUser.contacts[indexPath.row].contactName
        cell.numberLabelCell.text = AgendaData.shared.currentUser.contacts[indexPath.row].contactPhone
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        AgendaData.shared.row = indexPath.row
    }
}





