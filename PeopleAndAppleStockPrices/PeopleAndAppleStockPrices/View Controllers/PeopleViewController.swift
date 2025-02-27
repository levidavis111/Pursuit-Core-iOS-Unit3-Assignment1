//
//  PeopleViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Levi Davis on 8/30/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class PeopleViewController: UIViewController {

    var contacts = [Contact]() {
        didSet {
            contactsTableView.reloadData()
        }
    }
    var searchString: String? = nil {
        didSet {
            self.contactsTableView.reloadData()
        }
    }
    
    var searchResults: [Contact] {
        get {
            return Results.getSearchResults(contactArr: contacts, search: searchString)
        }
    }
    
    
    @IBOutlet weak var searchBarOutlet: UISearchBar!
    @IBOutlet weak var contactsTableView: UITableView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is ContactsDetailViewController {
            guard let indexPath = contactsTableView.indexPathForSelectedRow,
                let contactsVC = segue.destination as? ContactsDetailViewController else {return}
            let oneContact = contacts[indexPath.row]
            contactsVC.contact = oneContact
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactsTableView.delegate = self
        contactsTableView.dataSource = self
        searchBarOutlet.delegate = self
        loadData()
    }
    

    private func loadData() {
        guard let pathToJSONFile = Bundle.main.path(forResource: "userinfo", ofType: "json") else {fatalError("Could not find path")}
        let url = URL(fileURLWithPath: pathToJSONFile)
        do {
            let data = try Data(contentsOf: url)
            let contactsFromJSON = Results.getContacts(from: data)
            contacts = contactsFromJSON
        } catch let loadDataError {
            fatalError("Error: \(loadDataError)")
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchString = searchBar.text?.lowercased()
    }
}

extension PeopleViewController: UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = contactsTableView.dequeueReusableCell(withIdentifier: "contactsCell", for: indexPath)
        let oneContact = searchResults[indexPath.row]
        cell.textLabel?.text = "\(oneContact.name.first) \(oneContact.name.last)"
        cell.detailTextLabel?.text = oneContact.location.city
        return cell
    }
    
}
