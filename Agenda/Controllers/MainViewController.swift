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
        
        //SPINNER
        let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large) // Create the spinner
        view.addSubview(activityIndicator) // add it as a  subview
        activityIndicator.color = UIColor.black
        activityIndicator.center = CGPoint(x: view.frame.size.width*0.5, y: view.frame.size.height*0.5) // put in the middle
        disableView()
        activityIndicator.startAnimating() // Start animating
        //SPINNER
        
        NetworkManager.shared.showContacts(completionHandler: {
            contacts in
            
            ContactClass.shared.contactsArray = contacts

            print("ContactClass", ContactClass.shared.contactsArray)
            
            self.tv.reloadData()
            
            self.ableView()
            activityIndicator.stopAnimating()
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tv.reloadData()
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
    
    func disableView(){
        view.isUserInteractionEnabled = false
        view.alpha = 0.5
    }
    
    func ableView(){
        view.isUserInteractionEnabled = true
        view.alpha = 1
    }
}





