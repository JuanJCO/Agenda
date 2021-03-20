//
//  MainViewController.swift
//  Agenda
//
//  Created by Jazz on 7/3/21.
//

import Foundation
import UIKit

class MainViewController: UIViewController, UISearchBarDelegate{

    static var shared: MainViewController = MainViewController()
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var tv: UITableView!
    @IBOutlet weak var cancelButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // SPINNER
        let activityIndicator = UIActivityIndicatorView(style: .white) // Create the activity indicator
        view.addSubview(activityIndicator) // add it as a  subview
        activityIndicator.center = CGPoint(x: view.frame.size.width*0.5, y: view.frame.size.height*0.75) // put in the middle
        activityIndicator.startAnimating() // Start animating
        // SPINNER
        
        NetworkManager.shared.showContacts(completionHandler: {
            contacts in
            
            ContactClass.shared.contactsArray = contacts

            print("ContactClass", ContactClass.shared.contactsArray)
            
            self.tv.reloadData()
            
            activityIndicator.stopAnimating()
        })
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tv.reloadData()
    }
    
    @IBAction func searchBtn(_ sender: Any) {
        
        
    }
    
    @IBAction func cancelBtn(_ sender: Any) {
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
        cell.mailCell.text = ContactClass.shared.contactsArray[indexPath.row].mail
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        AgendaData.shared.row = indexPath.row
    }
}





