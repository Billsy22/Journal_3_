//
//  EntryListTableViewController.swift
//  Journal_3_
//
//  Created by Taylor Bills on 2/9/19.
//  Copyright © 2019 Taylor Bills. All rights reserved.
//

import UIKit

class EntryListTableViewController: UITableViewController {

    // MARK: -  Properties
    @IBOutlet var entryListTableView: UITableView!
    
    // MARK: -  Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: -  Table View Data Source Functions
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EntryController.shared.entries.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: entryCellIdentifier, for: indexPath)
        let entry = EntryController.shared.entries[indexPath.row]
        cell.textLabel?.text = entry.title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.deleteRows(at: [indexPath], with: .fade)
            let entry = EntryController.shared.entries[indexPath.row]
            EntryController.shared.remove(entry: entry)
        }
    }
    
    // MARK: -  Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == entryDetailSegueIdentifier {
            guard let indexPath = entryListTableView.indexPathForSelectedRow else { return }
            let entry = EntryController.shared.entries[indexPath.row]
            guard let entryDetailViewController = segue.destination as? EntryDetailViewController else { return }
            entryDetailViewController.entry = entry
        }
    }
}
